# supabase-poc

「Supabase + GitHub で仮アプリを作れるか」を検証するプロジェクト（2026-10-09 開始）。題材は備品メモ。

## 役割分担（所属長確認中のため変更の可能性あり）
- Claude：コード・migration（`supabase/migrations/*.sql`）を作成し、作業ブランチへ push してプルリクエストを作成するまで。
- 利用者：プルリクエストの確認とマージのみ。
- Supabase：GitHub連携により main へのマージで migration を本番DBへ反映。

## 守ること
- リポジトリは Public。社内データ・個人情報・社名や担当者名を含む記述を commit しない。
- Claude は DB に接続しない・SQL を実行しない（`supabase db push` 等は `.claude/settings.json` で禁止済み）。
- main へ直接 push しない。作業ブランチ → プルリクエスト。
- `.env.local` や接続キーを commit しない。service_role キーは使わない。
- データはテストデータのみ。個人情報・社内実データは入れない。
- GitHub Actions のワークフロー・secrets は追加しない。
- migration ファイルは追加のみ。マージ済みのファイルは書き換えず、変更は新しいファイルで行う。

## 構成
- Vite + JavaScript（`index.html`, `src/`）
- `@supabase/supabase-js` で anon キーを使って接続
- 起動：`npm install` → `npm run dev`
