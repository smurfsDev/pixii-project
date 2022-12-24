import { findUserByUsername, getUsers, removeRoleUser } from "../controllers/user.controller";
module.exports = (app: any) => {


	// Create a new claim
	app.get("/node/users", getUsers);
	app.get("/node/find/:username", findUserByUsername);
	app.get("/node/removeRoleUser/:role/:username", removeRoleUser);

}

