import express from 'express';
import logger from './utils/logger';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import cors from 'cors';
import helmet from 'helmet';
import compression from 'compression';
import router from './routers';
import config from './config';

const app = express();

app.use(cors({
    credentials: true,
}));
app.use(helmet());
app.use(compression());
app.use(cookieParser());
app.use(bodyParser.json());


app.use('/', router());

// const server = http.createServer(app);
const PORT = config.port;
app.listen(PORT, () => {
    logger.info('Server running on http://localhost:' + PORT)
});