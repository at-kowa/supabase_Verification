# supabase_Verification

supabase と GitHub の使い方を試すための、個人のタスク管理表アプリです。テストデータだけを入れます。

## 構成

| 場所 | 中身 |
|---|---|
| `app/index.html` | 画面（タスクの追加・状態と優先度と期限の変更・削除・絞り込み・並べ替え） |
| `app/config.example.js` | 接続先の書き方の見本。コピーして `app/config.js` を作る |
| `supabase/migrations/` | テーブル定義の SQL（テーブル名は `practice03_tasks`） |

## はじめての準備（1回だけ）

### 1. テーブルを作る（supabase CLI）

PowerShell をリポジトリのフォルダで開き、次を順に実行します。

```powershell
supabase login
supabase link --project-ref <プロジェクトの Reference ID>
supabase migration list
supabase db push
```

- `supabase login`：Edge が開くので、supabase にログインして承認します。
- `<プロジェクトの Reference ID>`：管理画面の「Project Settings」→「General」にある英数字 20 文字です。
- `supabase link` の途中で聞かれるデータベースのパスワードは、ご自身で入力します（チャットには貼らない）。
- `supabase migration list` で、**Local の列に `20261020000000` だけがあり、Remote の列に見覚えのない行がない**ことを確認してから `db push` してください。Remote に他の行がある場合は、チームの変更履歴と食い違うので、`db push` せずに相談してください。

### 2. 接続先を書く

1. `app/config.example.js` をコピーして、同じフォルダに `app/config.js` を作ります。
2. 管理画面の「Project Settings」→「API」にある **Project URL** と **anon（public）キー** を書き込みます。
   - `service_role` キーは絶対に書かないでください。

### 3. 画面を開く

`app/index.html` を Edge で開きます（ダブルクリックで開けます）。

## 注意

- リポジトリは Public です。タスク名に業務の内容や個人情報を書かないでください。
- ログインなしのテストアプリなので、接続先を知っている人は誰でもこのテーブルを読み書きできます。
