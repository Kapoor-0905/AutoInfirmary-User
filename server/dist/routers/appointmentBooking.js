"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const middleware_1 = require("../middleware");
const appointmentBooking_1 = require("../controllers/appointmentBooking");
exports.default = (router) => {
    router.get('/appointments/:userId', middleware_1.isAuthenticated, appointmentBooking_1.getUserAppointmentBookings);
    router.get('/appointments/', middleware_1.isAuthenticated, appointmentBooking_1.getAppointmentBookings);
    router.post('/appointments', middleware_1.isAuthenticated, appointmentBooking_1.createAppointmentBooking);
    router.delete('/appointments/:id', middleware_1.isAuthenticated, middleware_1.isOwner, appointmentBooking_1.deleteAppointmentBooking);
    router.patch('/appointments/:id', middleware_1.isAuthenticated, middleware_1.isOwner, appointmentBooking_1.updateAppointmentBooking);
};
//# sourceMappingURL=appointmentBooking.js.map