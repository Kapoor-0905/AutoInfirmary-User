import express from 'express';
import logger from './utils/logger';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import cors from 'cors';
import helmet from 'helmet';
import compression from 'compression';
import router from './routers';

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
var port = process.env.PORT || 4207;
app.listen(port, () => {
    logger.info('Server running on http://localhost:' + port)
});