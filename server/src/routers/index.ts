import express from 'express';

import authentication from './authentication';
import api from './api';
import users from './users';
import emergencyContact from './emergencyContact';

const router = express.Router();

export default (): express.Router => {
    authentication(router);
    api(router);
    users(router);
    emergencyContact(router);
    return router;
}