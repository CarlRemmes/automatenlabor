create table if not exists public.worksheet_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade unique,
  student_key text not null unique,
  student_name text not null default '',
  current_index integer not null default 0,
  answers jsonb not null default '{}'::jsonb,
  skipped jsonb not null default '[]'::jsonb,
  helper_enabled boolean not null default false,
  finished_at timestamptz,
  downloaded_at timestamptz,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

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
  select encode(digest(input_pin, 'sha256'), 'hex') =
    'a7fc7be25bddd2b0be5cbc208ea6d2ff868801513abe5ce03d4079bd66167180';
$$;

grant execute on function public.verify_helper_pin(text) to anon, authenticated;
