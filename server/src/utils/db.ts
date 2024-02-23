import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const connect = async () => {
    await prisma.$connect()   
}

connect();

export default prisma;