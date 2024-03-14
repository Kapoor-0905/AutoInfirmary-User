import { isAuthenticated, isOwner } from '../middleware';
import express from 'express';
import { getSingleEmergencyContact, getAllEmergencyContacts, createEmergencyContact, deleteEmergencyContact, updateEmergencyContact} from '../controllers/emergencyContacts';

export default (router: express.Router) => {
    router.get('/contacts', isAuthenticated , getAllEmergencyContacts)
    router.get('/contacts/:id', isAuthenticated, getSingleEmergencyContact)
    router.post('/contacts', isAuthenticated, createEmergencyContact)
    router.delete('/contacts/:id', isAuthenticated, isOwner, deleteEmergencyContact)
    router.patch('/contacts/:id', isAuthenticated, isOwner, updateEmergencyContact)
};