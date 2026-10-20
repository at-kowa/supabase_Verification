# supabase_Verification

supabase + GitHub の検証用に作る、個人のタスク管理表アプリ。リポジトリは **Public** なので、社外秘情報・個人情報・接続キーは絶対に含めない。

## 役割分担

| 作業 | 担当 |
|---|---|
| 作業ブランチ作成・実装・テスト・commit・push・PR 作成 | Claude（自律的に進めてよい） |
| PR の確認と main へのマージ | 本人 |
| DB 変更の SQL 作成（`supabase/migrations/` にファイルとして作る） | Claude |
| SQL の適用（`supabase db push` 等）、supabase の管理画面操作 | 本人 |
| `.env` への接続キーの記入、GitHub のリポジトリ設定・Actions・secrets | 本人 |

## ルール

- main で直接作業しない。1つの作業ごとに `feat/…` `fix/…` `chore/…` のブランチを切る。
- main への push、force push、履歴の書き換えはしない。
- Claude は DB に直接 SQL を実行しない（テーブル作成・データ変更・権限付与を含む）。必要な変更はマイグレーションファイルとして作り、PR に含める。
- 接続キー・パスワードはコードやチャットに書かない。`.env` は本人が記入し、Git に含めない（`.env.example` にはキー名だけを書く）。
- `service_role` キーはアプリに使わない。フロントエンドからは anon キーのみを使い、テーブルには必ず RLS（行レベルセキュリティ）を設定する。
- 個人情報・口座番号・マイナンバー等を保存する設計にしない。
- commit メッセージと PR の説明は日本語で書く。PR には変更内容と確認方法を書く。
