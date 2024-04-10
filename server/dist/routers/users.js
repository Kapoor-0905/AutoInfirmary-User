"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const middleware_1 = require("../middleware");
const users_1 = require("../controllers/users");
exports.default = (router) => {
    router.get('/users/:id', middleware_1.isAuthenticated, users_1.getSingleUser);
    router.get('/users', middleware_1.isAuthenticated, users_1.getAllUsers);
    router.delete('/users/:id', middleware_1.isAuthenticated, middleware_1.isOwner, users_1.deleteUser);
    router.patch('/users/:id', middleware_1.isAuthenticated, middleware_1.isOwner, users_1.updateUser);
    router.patch('/users/:id/profile-picture', middleware_1.isAuthenticated, middleware_1.isOwner, users_1.updateProfilePicture);
};
//# sourceMappingURL=users.js.map