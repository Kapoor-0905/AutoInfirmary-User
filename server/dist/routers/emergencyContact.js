"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const middleware_1 = require("../middleware");
const emergencyContacts_1 = require("../controllers/emergencyContacts");
exports.default = (router) => {
    router.get('/contacts/:userId', middleware_1.isAuthenticated, emergencyContacts_1.getAllUserEmergencyContacts);
    router.post('/contacts', middleware_1.isAuthenticated, emergencyContacts_1.createEmergencyContact);
    router.delete('/contacts/:id', middleware_1.isAuthenticated, middleware_1.isOwner, emergencyContacts_1.deleteEmergencyContact);
    router.patch('/contacts/:id', middleware_1.isAuthenticated, middleware_1.isOwner, emergencyContacts_1.updateEmergencyContact);
};
//# sourceMappingURL=emergencyContact.js.map