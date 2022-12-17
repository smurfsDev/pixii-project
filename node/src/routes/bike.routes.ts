import { CheckExist } from "../controllers/bike.controller";

module.exports = (app: any) => {
	app.get("/node/bike/checkExist/:id", CheckExist);
};