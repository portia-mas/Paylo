-- Paylo database setup. Paste this whole file into Supabase > SQL Editor > Run.

-- 1. Signed, append-only ledger (users can add rows but never edit or delete them)
create table if not exists public.ledger_entries (
  id        text primary key,
  user_id   uuid not null default auth.uid() references auth.users(id) on delete cascade,
  ts        bigint not null,
  type      text not null check (type in ('sale','expense')),
  amount    numeric not null,
  method    text not null check (method in ('cash','qr','link')),
  label     text,
  status    text default 'synced',
  sig       text not null,
  reverses  text,
  created_at timestamptz default now()
);
create index if not exists ledger_user_ts on public.ledger_entries (user_id, ts);

-- 2. Trader profile, consents and sharing choices
create table if not exists public.profiles (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data    jsonb default '{}'::jsonb,
  updated_at timestamptz default now()
);

-- 3. Activity / audit log the trader can read
create table if not exists public.audit_log (
  id      bigserial primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  ts      bigint not null,
  kind    text,
  msg     text
);

-- 4. Row-level security: every user sees only their own rows
alter table public.ledger_entries enable row level security;
alter table public.profiles       enable row level security;
alter table public.audit_log      enable row level security;

drop policy if exists "ledger select own" on public.ledger_entries;
drop policy if exists "ledger insert own" on public.ledger_entries;
create policy "ledger select own" on public.ledger_entries for select using (auth.uid() = user_id);
create policy "ledger insert own" on public.ledger_entries for insert with check (auth.uid() = user_id);
-- no update or delete policy on purpose: the ledger is append-only

drop policy if exists "profile select own" on public.profiles;
drop policy if exists "profile insert own" on public.profiles;
drop policy if exists "profile update own" on public.profiles;
create policy "profile select own" on public.profiles for select using (auth.uid() = user_id);
create policy "profile insert own" on public.profiles for insert with check (auth.uid() = user_id);
create policy "profile update own" on public.profiles for update using (auth.uid() = user_id);

drop policy if exists "audit select own" on public.audit_log;
drop policy if exists "audit insert own" on public.audit_log;
create policy "audit select own" on public.audit_log for select using (auth.uid() = user_id);
create policy "audit insert own" on public.audit_log for insert with check (auth.uid() = user_id);

-- 5. Right to erasure (POPIA): the only way a user can remove their data
create or replace function public.erase_my_data()
returns void language sql security definer set search_path = public as $$
  delete from public.ledger_entries where user_id = auth.uid();
  delete from public.audit_log      where user_id = auth.uid();
  delete from public.profiles       where user_id = auth.uid();
$$;
revoke all on function public.erase_my_data() from public, anon;
grant execute on function public.erase_my_data() to authenticated;