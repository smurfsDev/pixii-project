import { CheckExist, FindById } from "../controllers/bike.controller";

module.exports = (app: any) => {
	app.get("/node/bike/checkExist/:id", CheckExist);
	app.get("/node/bike/:id", FindById);
};