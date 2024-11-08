const rpc = require("discord-rpc")
const express = require("express")

const app = express()
const port = 3043

app.use(express.json())

const clientId = '1304518754834579546'
rpc.register(clientId)
const client = new rpc.Client({ transport: 'ipc' })

client.on('ready', () => {
  console.log('Discord RPC is ready')
})

const d=new Date()

app.post('/updatePresence', (req, res) => {
  const { details, state, largeImageKey, largeImageText } = req.body

  if (!details || !state || !largeImageKey || !largeImageText) {
    return res.status(400).json({
      error: 'error :<',
      message: 'Uhh no data'
    })
  }

  client.setActivity({
    details: details,
    state: state,
    startTimestamp: d,
    largeImageKey: largeImageKey,
    largeImageText: largeImageText,
  })


  return res.status(200).json({
    message: 'RICH',
    data: req.body
  })
})

app.get('/', (req, res) => {
  res.json({ message: 'Hello!' })
})

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`)
})

client.login({ clientId }).catch(console.error)
