import { NextFunction, Request, Response } from "express";
import Role from "../models/role.model";
import User from "../models/user.model";


export const fetchUser = async (req: Request, res: Response, next: NextFunction) => {

	if (req.path.includes("role") || req.path.includes("register") || req.path.includes("bike")) {

		next();
	} else {
		let token = req.header('AutorizationNode');
		const user = await User.findOne
			({ email: token });

		if (user) {
			req.body.user = user;
			for (let index = 0; index < req.body.user.roles.length; index++) {
				const element = req.body.user.roles[index];
				let roleUser = await Role.findOne({ _id: element.role })
				if (element.status == 1 && roleUser) {
					const name = roleUser.get("name")
					if (name == "Admin") {
						req.body.isAdmin = true
					}
					if (name == "Super Admin") {
						req.body.isSuperAdmin = true
					}
					if (name == "SAV Technician") {
						req.body.isSAVTechnician = true
					}
					if (name == "SAV Manager") {
						req.body.isSAVManager = true
					}
					if (name == "Scooter Owner") {
						req.body.isScooterOwner = true
					}
				}
			}
			next();
		} else {
			res.status(401).send('Unauthorized');
		}
	}
};