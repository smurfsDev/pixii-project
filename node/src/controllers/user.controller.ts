import { Request, Response } from "express";
import Role from "../models/role.model";
import User from "../models/user.model";

export const getUsers = (req: Request, res: Response) => {
	Role.find({
		name: { $nin: ["Super Admin", "Admin", "Scooter Owner"] }
	}, (err: any, roles: any) => {
		if (err) return res.status(500).send("There was a problem finding the roles.");
		else {
			User.find(
				{
					$and: [
						{ "roles.status": 1 },
						{ "roles.role": { $in: roles } }
					]
				}, (err: any, users: any) => {
					if (err) return res.status(500).send
						("There was a problem finding the users.");
					else return res.status(200).send(users);
				});
		}
	});


};
export const getAllUsers = (req: Request, res: Response) => {
	User.find({}, (err: any, users: any) => {
		if (err) return res.status(500).send
			("There was a problem finding the users.");
		else return res.status(200).send(users);

	})
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
	if (req.body.isSuperAdmin) {
		const user = User.findOne
			({ username: req.params.username }, (err: Error, user: any) => {
				console.log("nombre de role : " + user.roles.length);
				if (user.roles.length == 1) {
					Role.find({ name: req.params.role }, (err: Error, role: any) => {
						if (err) return res.status(500).send()
						if (!role) return res.status(404).send("Role not found")
						else {

							const role1 = role[0]._id
							const role2 = user.roles[0].role[0]

							console.log(role[0]._id.equals(user.roles[0].role[0]))
							if ((role[0]._id).equals(user.roles[0].role[0])) {
								user.remove((err: any) => {
									if (err) return res.status(500).send(err);
									else return res.status(200).send("Role removed successfully");
								});
							}
							else {
								return res.status(404).send("User haven't this role")

							}
						}
					})

				}
				else {
					for (let index = 0; index < user.roles.length; index++) {
						const element = user.roles[index];
						let fetchRole = Role.findById({ _id: element.role }, async (err: Error, roleUser: any) => {
							console.log(roleUser)
							if (req.params.role === roleUser.name) {
								console.log(roleUser)
								console.log(user.roles[index].role)
								User.updateOne({ username: req.params.username }, { $pull: { "roles": { "role": user.roles[index].role } } }, (err: Error, rowsAffected: any) => {
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
	else {
		res.status(401).send("You must be a Super Admin to access this page !")

	}

}

