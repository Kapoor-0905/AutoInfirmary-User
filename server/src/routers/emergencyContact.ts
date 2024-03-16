import { isAuthenticated, isOwner } from '../middleware';
import express from 'express';
import { getAllUserEmergencyContacts, createEmergencyContact, deleteEmergencyContact, updateEmergencyContact} from '../controllers/emergencyContacts';

export default (router: express.Router) => {
    router.get('/contacts/:userId', isAuthenticated , getAllUserEmergencyContacts)
    router.post('/contacts', isAuthenticated, createEmergencyContact)
    router.delete('/contacts/:id', isAuthenticated, isOwner, deleteEmergencyContact)
    router.patch('/contacts/:id', isAuthenticated, isOwner, updateEmergencyContact)
};