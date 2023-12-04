import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";

export async function teamHandler(app: FastifyInstance){
    app.get('/times', async (request, reply) => {
        try{
            const teams = await prisma.time.findMany()
            return reply.status(200).send(teams)
        } catch(error){
            console.error(error);
            reply.status(500).send('Internal server error')
        }
    })
}
