create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('teacher')),
  display_name text,
  created_at timestamptz not null default timezone('utc', now())
);

create or replace function public.is_teacher()
returns boolean
language sql
stable
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and role = 'teacher'
  );
$$;

create table if not exists public.missions (
  code text primary key,
  status text not null default 'waiting' check (status in ('waiting', 'live', 'paused')),
  broadcast_message text not null default '',
  teacher_hint text not null default '',
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.student_sessions (
  id uuid primary key default gen_random_uuid(),
  mission_code text not null references public.missions(code) on delete cascade,
  student_key text not null unique,
  user_id uuid not null references auth.users(id) on delete cascade,
  first_name text not null,
  class_name text not null,
  current_question_index integer not null default 0,
  forced_question_index integer not null default 0,
  teacher_message text not null default '',
  note_preview text not null default '',
  has_submitted boolean not null default false,
  snapshot_requested_at timestamptz,
  snapshot_path text,
  snapshot_updated_at timestamptz,
  last_seen_at timestamptz not null default timezone('utc', now()),
  unique (mission_code, user_id)
);

create table if not exists public.submissions (
  id uuid primary key default gen_random_uuid(),
  mission_code text not null references public.missions(code) on delete cascade,
  student_key text not null,
  user_id uuid not null references auth.users(id) on delete cascade,
  first_name text not null,
  class_name text not null,
  answers jsonb not null default '{}'::jsonb,
  score integer not null default 0,
  max_score integer not null default 0,
  percentage integer not null default 0,
  note text not null default '',
  created_at timestamptz not null default timezone('utc', now()),
  unique (mission_code, user_id),
  unique (mission_code, student_key)
);

insert into public.missions (code, status, broadcast_message, teacher_hint)
values ('main', 'waiting', '', '')
on conflict (code) do nothing;

insert into storage.buckets (id, name, public)
values ('automatenlabor-snapshots', 'automatenlabor-snapshots', false)
on conflict (id) do nothing;

alter table public.profiles enable row level security;
alter table public.missions enable row level security;
alter table public.student_sessions enable row level security;
alter table public.submissions enable row level security;

drop policy if exists "profiles teacher self select" on public.profiles;
create policy "profiles teacher self select"
on public.profiles
for select
using (id = auth.uid());

drop policy if exists "missions read for authenticated users" on public.missions;
create policy "missions read for authenticated users"
on public.missions
for select
using (auth.uid() is not null);

drop policy if exists "missions teacher write" on public.missions;
create policy "missions teacher write"
on public.missions
for all
using (public.is_teacher())
with check (public.is_teacher());

drop policy if exists "student sessions self read" on public.student_sessions;
create policy "student sessions self read"
on public.student_sessions
for select
using (user_id = auth.uid());

drop policy if exists "student sessions self insert" on public.student_sessions;
create policy "student sessions self insert"
on public.student_sessions
for insert
with check (user_id = auth.uid());

drop policy if exists "student sessions self update" on public.student_sessions;
create policy "student sessions self update"
on public.student_sessions
for update
using (user_id = auth.uid())
with check (user_id = auth.uid());

drop policy if exists "student sessions teacher read" on public.student_sessions;
create policy "student sessions teacher read"
on public.student_sessions
for select
using (public.is_teacher());

drop policy if exists "student sessions teacher update" on public.student_sessions;
create policy "student sessions teacher update"
on public.student_sessions
for update
using (public.is_teacher())
with check (public.is_teacher());

drop policy if exists "student sessions teacher delete" on public.student_sessions;
create policy "student sessions teacher delete"
on public.student_sessions
for delete
using (public.is_teacher());

drop policy if exists "submissions self read" on public.submissions;
create policy "submissions self read"
on public.submissions
for select
using (user_id = auth.uid());

drop policy if exists "submissions self insert" on public.submissions;
create policy "submissions self insert"
on public.submissions
for insert
with check (user_id = auth.uid());

drop policy if exists "submissions self update" on public.submissions;
create policy "submissions self update"
on public.submissions
for update
using (user_id = auth.uid())
with check (user_id = auth.uid());

drop policy if exists "submissions teacher read" on public.submissions;
create policy "submissions teacher read"
on public.submissions
for select
using (public.is_teacher());

drop policy if exists "storage teacher read snapshots" on storage.objects;
create policy "storage teacher read snapshots"
on storage.objects
for select
using (
  bucket_id = 'automatenlabor-snapshots'
  and public.is_teacher()
);

drop policy if exists "storage student upload snapshots" on storage.objects;
create policy "storage student upload snapshots"
on storage.objects
for insert
with check (
  bucket_id = 'automatenlabor-snapshots'
  and auth.uid()::text = (storage.foldername(name))[1]
);

drop policy if exists "storage student update own snapshots" on storage.objects;
create policy "storage student update own snapshots"
on storage.objects
for update
using (
  bucket_id = 'automatenlabor-snapshots'
  and auth.uid()::text = (storage.foldername(name))[1]
)
with check (
  bucket_id = 'automatenlabor-snapshots'
  and auth.uid()::text = (storage.foldername(name))[1]
);

drop policy if exists "storage teacher delete snapshots" on storage.objects;
create policy "storage teacher delete snapshots"
on storage.objects
for delete
using (
  bucket_id = 'automatenlabor-snapshots'
  and public.is_teacher()
);
