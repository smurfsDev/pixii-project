import { Request, Response } from "express";
import User from "../models/user.model";

export const getUsers = (req: Request, res: Response) => {
	User.find({}, (err: any, users: any) => {
		if (err) return res.status(500).send
			("There was a problem finding the users.");
		else return res.status(200).send(users);
	});
};

export const getUserById = (req: Request, res: Response) => {
	User.findById(req.params.id), (err: any, user: any) => {
		if (err) return res.status(500).send(err);
		else {
			if (!user) return res.status(404).send("User not found")
			else {
				return res.status(200).send(user);
			}
		}

	}
}