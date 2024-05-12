import { isAuthenticated, isOwner } from '../middleware';
import express from 'express';
import { getAllUserEmergencyContacts, createEmergencyContact, deleteEmergencyContact, updateEmergencyContact } from '../controllers/emergencyContacts';

export default (router: express.Router) => {
    router.get('/contacts/:userId', isAuthenticated, getAllUserEmergencyContacts)
    router.post('/contacts', isAuthenticated, createEmergencyContact)
    router.delete('/contacts/:userID/:id', isAuthenticated, deleteEmergencyContact)
    router.patch('/contacts/:userID/:id', isAuthenticated, updateEmergencyContact)
};