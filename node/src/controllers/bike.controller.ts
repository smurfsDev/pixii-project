import { Request, Response } from "express";
import BikeData from "../models/bike.model";
import User from "../models/user.model";

// find by id
export const CheckExist = (req: Request, res: Response) => {
	BikeData.findOne({id:req.params.id}, (err: Error, bike: any) => {
		if (!bike||err) return res.status(200).send(false);
		else {
			// User.find({'roles.scooterId':req.params.id})
			// get the count of users with the given id
			User.countDocuments({'roles.scooterId':req.params.id}, function (err:any, count:number) {
				if (err) return res.status(200).send(false);
				else if (count>0) return res.status(200).send(false);
				else return res.status(200).send(true);
			});
		}
	});
};

// find by id
export const FindById = (req: Request, res: Response) => {
	BikeData.findOne({id:req.params.id}, (err: Error, bike: any) => {
		if (err) return res.status(500).send();
		if (!bike) return res.status(404).send();
		return res.status(200).send(bike);
	});
};

// lock bike
export const ChangeLockState = (req: Request, res: Response) => {
	BikeData.findOne({id:req.params.id}, (err: Error, bike: any) => {
		if (err) return res.status(500).send();
		if (!bike) return res.status(404).send();
		bike.TheftState = req.body.TheftState;
		bike.save();
		return res.status(200).send(bike);
	});
}

// turn on/off light
export const ChangeLightState = (req: Request, res: Response) => {
	BikeData.findOne({id:req.params.id}, (err: Error, bike: any) => {
		if (err) return res.status(500).send();
		if (!bike) return res.status(404).send();
		bike.LightState = req.body.LightState;
		bike.save();
		return res.status(200).send(bike);
	});
}

// turn on/off alarm
export const ChangeAlarmState = (req: Request, res: Response) => {
	BikeData.findOne({id:req.params.id}, (err: Error, bike: any) => {
		if (err) return res.status(500).send();
		if (!bike) return res.status(404).send();
		bike.AlarmState = req.body.AlarmState;
		bike.save();
		return res.status(200).send(bike);
	});
}
