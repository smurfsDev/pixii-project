import { NextFunction, Request, Response } from "express";
import User from "../models/user.model";


export const fetchUser = async (req: Request, res: Response, next: NextFunction) => {
	let token = req.header('AutorizationNode');
	const user = await User.findOne
		({ email: token });
	if (user) {
		req.body.user = user;
		next();
	} else {
		res.status(401).send('Unauthorized');
	}
};