import express from 'express';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import helmet from 'helmet';
import morgan from 'morgan';
import cors from 'cors';
import router from './routes/index';


const app = express();

app.use(cors({
    origin: 'http://localhost:3000',
    credentials: true
}));
app.use(helmet());
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(router)

export default app;