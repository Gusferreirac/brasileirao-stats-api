import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";

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

    app.post('/jogadores', async (request, reply) => {
        if(!request.body) return reply.status(400).send('Bad Request');
        try {
            const playerSchema = z.object({
                    nome: z.string(),
                    apelido: z.string(),
                    posicao: z.string(),
                    foto: z.string().nullable(),
                    time_nome: z.string(),
                    time_complemento: z.string(),
                    time_anterior: z.string().nullable(),
                    data_nascimento: z.string(),
                    nacionalidade: z.string(),
                    suspenso: z.boolean(),
            });

            const playerInfo = playerSchema.parse(request.body) 
            
            await prisma.jogador.create({
                data: {
                    nome: playerInfo.nome,
                    apelido: playerInfo.apelido,
                    posicao: playerInfo.posicao,
                    foto: playerInfo.foto,
                    time_nome: playerInfo.time_nome,
                    time_complemento: playerInfo.time_complemento,
                    time_anterior: playerInfo.time_anterior,
                    data_nascimento: playerInfo.data_nascimento,
                    nacionalidade: playerInfo.nacionalidade,
                    suspenso: playerInfo.suspenso,
                },
            })

            return reply.status(200).send(true);
        } catch (error) {
            console.error(error);
            reply.status(500).send('Internal Server Error');
        }
    })
}