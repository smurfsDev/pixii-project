
import { findUserByUsername, getAllUsers, getUsers, removeRoleUser } from "../controllers/user.controller";

module.exports = (app: any) => {


	// Create a new claim
	app.get("/node/users", getUsers);
	app.get("/node/allUsers", getAllUsers);

	app.get("/node/find/:username", findUserByUsername);
	app.put("/node/removeRoleUser/:role/:username", removeRoleUser);


}

