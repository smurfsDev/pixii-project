import { NextFunction, Request, Response } from "express";
import Role from "../models/role.model";
import User from "../models/user.model";


export const fetchUser = async (req: Request, res: Response, next: NextFunction) => {

	if (req.path.includes("role") || req.path.includes("register") || req.path.includes("bike") || req.path.includes("accept") || req.path.includes("refuse") || req.path.includes("removeRoleUser")) {

		next();
	} else {
		let token = req.header('AutorizationNode');
		const user = await User.findOne
			({ email: token });

		if (user) {
			console.log("aaaa")
			req.body.user = user;
			for (let index = 0; index < req.body.user.roles.length; index++) {
				const element = req.body.user.roles[index];
				let fetchRole = await Role.find({ _id: element._id }, async (err: Error, roleUser: any) => {

					if (element.status == 1) {
						if (roleUser[0].name == "Admin") {
							req.body.isAdmin = true
						}
						if (roleUser[0].name == "Super Admin") {
							req.body.isSuperAdmin = true
						}
						if (roleUser[0].name == "SAV Technician") {
							req.body.isSAVTechnician = true
						}
						if (roleUser[0].name == "SAV Manager") {
							req.body.isSAVManager = true
						}
						if (roleUser[0].name == "Scooter Owner") {
							req.body.isScooterOwner = true
						}
					}
				}).clone()
			}
			next();
		} else {
			res.status(401).send('Unauthorized');
		}
	}
};