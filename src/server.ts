import {fastify} from 'fastify'
import cors, { fastifyCors } from '@fastify/cors'
import { playerHandler } from './routes/jogador'
import { teamHandler } from './routes/time'

const app = fastify()

app.register(cors, {
    origin: true,
})
app.register(playerHandler)
app.register(teamHandler)

app.listen({
    port: 3333,
}).then(() => {
    console.log('Server is running on port 3333')
})
