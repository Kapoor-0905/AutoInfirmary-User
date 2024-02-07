import * as dotenv from 'dotenv';
dotenv.config();

import config from '../config';

import http from 'http';
import app from "./server";
import { connectWithRetry } from './utils/db';

const server = http.createServer(app);
const port = config.port;

server.listen(port, () => {
    console.log(`Server is running on port http://localhost:${config.port}`);
    connectWithRetry();
});