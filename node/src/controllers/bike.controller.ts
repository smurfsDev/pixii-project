import { Request, Response } from "express";
import BikeData from "../models/bike.model";

// find by id
export const CheckExist = (req: Request, res: Response) => {
	BikeData.findOne({id:req.params.id}, (err: Error, bike: any) => {
		if (!bike||err) return res.status(200).send(false);
		else return res.status(200).send(true);
	});
};
