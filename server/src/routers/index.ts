import express from 'express';

import authentication from './authentication';
import api from './api';

const router = express.Router();

export default (): express.Router => {
    authentication(router);
    api(router);
    return router;
}