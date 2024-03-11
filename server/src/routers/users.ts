import { isAuthenticated, isOwner } from '../middleware';
import { deleteUser, getAllUsers, getSingleUser, updateUser } from '../controllers/users';
import express from 'express';

export default (router: express.Router) => {
    router.get('/users/:id', isAuthenticated, getSingleUser)
    router.get('/users', isAuthenticated ,getAllUsers)
    router.delete('/users/:id', isAuthenticated, isOwner, deleteUser)
    router.patch('/users/:id', isAuthenticated, isOwner, updateUser)
};