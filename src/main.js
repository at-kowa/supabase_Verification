import { createClient } from '@supabase/supabase-js'

const url = import.meta.env.VITE_SUPABASE_URL
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

const statusEl = document.getElementById('status')
const listEl = document.getElementById('memo-list')
const form = document.getElementById('memo-form')

if (!url || !anonKey) {
  statusEl.textContent = '.env.local に VITE_SUPABASE_URL と VITE_SUPABASE_ANON_KEY を設定してください。'
  form.querySelector('button').disabled = true
  throw new Error('Supabase の接続設定がありません')
}

const supabase = createClient(url, anonKey)

async function loadMemos() {
  const { data, error } = await supabase
    .from('memos')
    .select('id, title, note, created_at')
    .order('created_at', { ascending: false })

  if (error) {
    statusEl.textContent = `読み込みエラー：${error.message}`
    return
  }

  listEl.replaceChildren(
    ...data.map((m) => {
      const li = document.createElement('li')
      const date = new Date(m.created_at).toLocaleString('ja-JP')
      li.textContent = `${m.title}${m.note ? '：' + m.note : ''}（${date}）`
      return li
    })
  )
  statusEl.textContent = `${data.length} 件`
}

form.addEventListener('submit', async (e) => {
  e.preventDefault()
  const title = document.getElementById('title').value.trim()
  const note = document.getElementById('note').value.trim()
  if (!title) return

  const { error } = await supabase.from('memos').insert({ title, note: note || null })
  if (error) {
    statusEl.textContent = `登録エラー：${error.message}`
    return
  }
  form.reset()
  await loadMemos()
})

loadMemos()
