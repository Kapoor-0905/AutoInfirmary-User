"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const middleware_1 = require("../middleware");
const emergencyBooking_1 = require("../controllers/emergencyBooking");
exports.default = (router) => {
    router.get('/emergency/:userId', middleware_1.isAuthenticated, emergencyBooking_1.getUserEmergencyAppointmentBookings);
    router.get('/emergency/', middleware_1.isAuthenticated, emergencyBooking_1.getEmergencyAppointmentBookings);
    router.post('/emergency', middleware_1.isAuthenticated, emergencyBooking_1.createEmergencyBooking);
    router.delete('/emergency/:id', middleware_1.isAuthenticated, middleware_1.isOwner, emergencyBooking_1.deleteEmergencyAppointmentBooking);
    router.patch('/emergency/:id', middleware_1.isAuthenticated, middleware_1.isOwner, emergencyBooking_1.updateEmergencyAppointmentBooking);
};
//# sourceMappingURL=emergencyBooking.js.map