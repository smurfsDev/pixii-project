import { ChangeAlarmState, ChangeLightState, ChangeLockState, CheckExist, FindById } from "../controllers/bike.controller";

module.exports = (app: any) => {
	app.get("/node/bike/checkExist/:id", CheckExist);
	app.get("/node/bike/:id", FindById);
	app.put("/node/bike/lock/:id", ChangeLockState);
	app.put("/node/bike/light/:id", ChangeLightState);
	app.put("/node/bike/alarm/:id", ChangeAlarmState);

};