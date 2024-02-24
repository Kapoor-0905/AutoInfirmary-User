import { PrismaClient } from "@prisma/client";
import logger from "./logger";

const prisma = new PrismaClient();

export const connect = async () => {
    await prisma.$connect()
    logger.info("Connected to the database")
}

connect();

export default prisma;