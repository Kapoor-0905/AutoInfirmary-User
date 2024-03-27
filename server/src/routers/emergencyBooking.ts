import { isAuthenticated, isOwner } from "../middleware";
import express from 'express';
import { getEmergencyAppointmentBookings, getUserEmergencyAppointmentBookings, createEmergencyBooking, updateEmergencyAppointmentBooking, deleteEmergencyAppointmentBooking } from '../controllers/emergencyBooking';

export default (router: express.Router) => {
    router.get('/emergency/:userId', isAuthenticated, getUserEmergencyAppointmentBookings)
    router.get('/emergency/', isAuthenticated, getEmergencyAppointmentBookings)
    router.post('/emergency', isAuthenticated, createEmergencyBooking)
    router.delete('/emergency/:id', isAuthenticated, isOwner, deleteEmergencyAppointmentBooking)
    router.patch('/emergency/:id', isAuthenticated, isOwner, updateEmergencyAppointmentBooking)
}