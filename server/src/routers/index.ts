import express from 'express';

import authentication from './authentication';
import api from './api';
import users from './users';
import emergencyContact from './emergencyContact';
import appointmentBooking from './appointmentBooking';
import emergencyBooking from './emergencyBooking';

const router = express.Router();

export default (): express.Router => {
    authentication(router);
    api(router);
    users(router);
    emergencyContact(router);
    appointmentBooking(router);
    emergencyBooking(router);
    return router;
}