-- 備品メモ（検証用）テーブル
create table public.memos (
  id bigint generated always as identity primary key,
  title text not null check (char_length(title) <= 100),
  note text check (char_length(note) <= 500),
  created_at timestamptz not null default now()
);

-- 行レベルセキュリティを有効化（検証用：閲覧と登録のみ許可、更新・削除は不可）
alter table public.memos enable row level security;

create policy "memos_select_anon" on public.memos
  for select to anon using (true);

create policy "memos_insert_anon" on public.memos
  for insert to anon with check (true);
