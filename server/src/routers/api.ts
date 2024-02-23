import express, { Request, Response } from 'express';
import logger from '../utils/logger';

export default (router: express.Router) => {
    router.get('/api/healthcheck', (req: Request, res: Response) => {
        logger.info('Healthcheck');
        res.send({
            message: "Healthcheck endpoint"
        });
    });
}