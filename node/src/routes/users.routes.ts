import { getUserById, getUsers } from "../controllers/user.controller";
module.exports = (app: any) => {


	// Create a new claim
	app.get("/node/users", getUsers);
	app.get("/node/find/:id", getUserById);

}

