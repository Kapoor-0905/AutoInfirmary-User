import { isAuthenticated, isOwner } from "../middleware";
import express from 'express';
import { getUserAppointmentBookings, getAppointmentBookings, createAppointmentBooking, deleteAppointmentBooking, updateAppointmentBooking } from '../controllers/appointmentBooking';

export default (router: express.Router) => {
    router.get('/appointments/:userId', isAuthenticated, getUserAppointmentBookings)
    router.get('/appointments/', isAuthenticated, getAppointmentBookings)
    router.post('/appointments', isAuthenticated, createAppointmentBooking)
    router.delete('/appointments/:userID/:id', isAuthenticated, deleteAppointmentBooking)
    router.patch('/appointments/:userID/:id', isAuthenticated, updateAppointmentBooking)
}