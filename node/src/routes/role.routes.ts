import { findAll, create, remove, findOne, findRoleIdByName, findRoleIdByNameBody } from '../controllers/role.controller';
module.exports = (app: any) => {


    // Create a new role
    app.post("/node/role", create);

    // Retrieve all roles
    app.get("/node/role", findAll);

    // Find role by id
    app.get("/node/role/:id", findOne);


    // Delete a role with roleId
    app.delete("/node/role/:id", remove);

    //find role by name
    app.get("/node/role/findName/:name", findRoleIdByName);

    //find role by name
    app.post("/node/role/findNameBody", findRoleIdByNameBody);


}