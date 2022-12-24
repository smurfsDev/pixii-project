import { Request, Response } from "express";
import Role from "../models/role.model";
import User from "../models/user.model";

export const getUsers = (req: Request, res: Response) => {
	User.find({}, (err: any, users: any) => {
		if (err) return res.status(500).send
			("There was a problem finding the users.");
		else return res.status(200).send(users);
	});
};


export const findUserByUsername = (req: Request, res: Response) => {

	User.findOne({ username: req.params.username }, (err: Error, user: any) => {
		if (err) return res.status(500).send(err);
		else if (!user) return res.status(404).send("User not found");
		else
			return res.status(200).send(user._id);
	})


};

export const removeRoleUser = (req: Request, res: Response) => {
	const user = User.findOne
		({ username: req.params.username }, (err: Error, user: any) => {
			console.log(user.roles);
			console.log(user.roles.length);
			if (user.roles.length == 1) {
				console.log(user)
				user.remove((err: any) => {
					if (err) return res.status(500).send(err);
					else return res.status(200).send("Role removed successfully");
				});
			}
			else {
				for (let index = 0; index < user.roles.length; index++) {
					const element = user.roles[index];
					let fetchRole = Role.find({ _id: element._id }, async (err: Error, roleUser: any) => {
						console.log(roleUser[0].name)
						if (req.params.role === roleUser[0].name) {
							console.log(roleUser)
							console.log(user.roles[index]._id)
							User.updateOne({ username: req.params.username }, { $pull: { "roles": { "_id": user.roles[index]._id } } }, (err: Error, rowsAffected: any) => {
								if (err) return res.status(500).send(err);
								if (!rowsAffected) return res.status(404).send("not found");
								else return res.status(200).send("Role removed successfully");
							})

						}

					})
				}
			}


		});


}

