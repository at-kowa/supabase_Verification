-- 個人タスク管理表のテーブル
-- 共有のテスト用プロジェクトに間借りするため、作るものはすべて practice03_ で始まる名前にし、
-- 他のテーブルや設定には一切触れない。

create table if not exists public.practice03_tasks (
  id          bigint generated always as identity primary key,
  title       text        not null check (char_length(title) between 1 and 200),
  status      text        not null default 'todo' check (status in ('todo', 'doing', 'done')),
  priority    smallint    not null default 2 check (priority between 1 and 3),
  due_date    date,
  note        text        check (char_length(note) <= 1000),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

comment on table public.practice03_tasks is 'supabase_Verification（個人タスク管理表のテストアプリ）用。テストデータのみ。';

-- 更新日時を自動で更新する
create or replace function public.practice03_set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists practice03_tasks_set_updated_at on public.practice03_tasks;
create trigger practice03_tasks_set_updated_at
  before update on public.practice03_tasks
  for each row execute function public.practice03_set_updated_at();

-- RLS（行レベルセキュリティ）
-- 今回はログインなしのテストアプリなので、anon キーからの読み書きをこのテーブルに限って許可する。
-- ログインを導入するときは、このポリシーを本人の行だけに絞るものへ置き換える。
alter table public.practice03_tasks enable row level security;

drop policy if exists practice03_tasks_anon_all on public.practice03_tasks;
create policy practice03_tasks_anon_all
  on public.practice03_tasks
  for all
  to anon, authenticated
  using (true)
  with check (true);

grant select, insert, update, delete on table public.practice03_tasks to anon, authenticated;
