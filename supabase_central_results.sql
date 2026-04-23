create extension if not exists pgcrypto;

create table if not exists public.worksheet_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade unique,
  student_key text not null unique,
  student_name text not null default '',
  last_name text not null default '',
  class_name text not null default '',
  current_index integer not null default 0,
  answers jsonb not null default '{}'::jsonb,
  reasons jsonb not null default '{}'::jsonb,
  skipped jsonb not null default '[]'::jsonb,
  helper_enabled boolean not null default false,
  question_order jsonb not null default '[]'::jsonb,
  timer_starts jsonb not null default '{}'::jsonb,
  started_at timestamptz,
  finished_at timestamptz,
  submitted_at timestamptz,
  report_path text,
  report_uploaded_at timestamptz,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

alter table public.worksheet_attempts
add column if not exists class_name text not null default '',
add column if not exists last_name text not null default '',
add column if not exists reasons jsonb not null default '{}'::jsonb,
add column if not exists question_order jsonb not null default '[]'::jsonb,
add column if not exists timer_starts jsonb not null default '{}'::jsonb,
add column if not exists started_at timestamptz,
add column if not exists submitted_at timestamptz,
add column if not exists report_path text,
add column if not exists report_uploaded_at timestamptz;

alter table public.worksheet_attempts enable row level security;

drop policy if exists "worksheet attempts self read" on public.worksheet_attempts;
create policy "worksheet attempts self read"
on public.worksheet_attempts
for select
using (user_id = auth.uid());

drop policy if exists "worksheet attempts self insert" on public.worksheet_attempts;
create policy "worksheet attempts self insert"
on public.worksheet_attempts
for insert
with check (user_id = auth.uid());

drop policy if exists "worksheet attempts self update" on public.worksheet_attempts;
create policy "worksheet attempts self update"
on public.worksheet_attempts
for update
using (user_id = auth.uid())
with check (user_id = auth.uid());

create or replace function public.verify_helper_pin(input_pin text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select encode(extensions.digest(input_pin::text, 'sha256'::text), 'hex') =
    'a7fc7be25bddd2b0be5cbc208ea6d2ff868801513abe5ce03d4079bd66167180';
$$;

grant execute on function public.verify_helper_pin(text) to anon, authenticated;

insert into storage.buckets (id, name, public)
values ('automatenlabor-reports', 'automatenlabor-reports', false)
on conflict (id) do nothing;

drop policy if exists "worksheet reports self insert" on storage.objects;
create policy "worksheet reports self insert"
on storage.objects
for insert
with check (
  bucket_id = 'automatenlabor-reports'
  and auth.uid()::text = (storage.foldername(name))[1]
);

drop policy if exists "worksheet reports self update" on storage.objects;
create policy "worksheet reports self update"
on storage.objects
for update
using (
  bucket_id = 'automatenlabor-reports'
  and auth.uid()::text = (storage.foldername(name))[1]
)
with check (
  bucket_id = 'automatenlabor-reports'
  and auth.uid()::text = (storage.foldername(name))[1]
);

drop policy if exists "worksheet reports self read" on storage.objects;
create policy "worksheet reports self read"
on storage.objects
for select
using (
  bucket_id = 'automatenlabor-reports'
  and auth.uid()::text = (storage.foldername(name))[1]
);
