import { isAuthenticated, isOwner } from "../middleware";
import express from 'express';
import { getAppointmentBookings, getUserAppointmentBookings, createEmergencyBooking, updateAppointmentBooking, deleteAppointmentBooking} from '../controllers/emergencyBooking';

export default (router: express.Router) => {
    router.get('/emergency/:userId', isAuthenticated, getUserAppointmentBookings)
    router.get('/emergency/', isAuthenticated, getAppointmentBookings)
    router.post('/emergency', isAuthenticated, createEmergencyBooking)
    router.delete('/emergency/:id', isAuthenticated, isOwner, deleteAppointmentBooking)
    router.patch('/emergency/:id', isAuthenticated, isOwner, updateAppointmentBooking)
}