import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";

export async function playerHandler(app: FastifyInstance){
    app.get('/jogadores', async (request, reply) => {
        try{
            const players = await prisma.jogador.findMany()
            return reply.status(200).send(players)
        } catch(error){
            console.error(error);
            reply.status(500).send('Internal server error')
        } 
    })
}