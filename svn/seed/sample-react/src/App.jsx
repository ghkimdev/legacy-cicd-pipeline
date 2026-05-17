import { useState, useEffect } from 'react'

function App() {
  const [count, setCount] = useState(0)
  const [version, setVersion] = useState('')

  useEffect(() => {
    // 빌드 시점에 주입되는 버전 정보
    setVersion(import.meta.env.VITE_APP_VERSION || 'dev')
  }, [])

  return (
    <div style={{ padding: '2rem', fontFamily: 'sans-serif' }}>
      <h1>Sample React App</h1>
      <p>Version: {version}</p>
      <p>Counter: {count}</p>
      <button onClick={() => setCount(count + 1)}>Click</button>
    </div>
  )
}

export default App
