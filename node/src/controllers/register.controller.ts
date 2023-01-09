
import { Request, Response } from 'express';
import User from "../models/user.model";
import Role from "../models/role.model";
import roleController, { findRoleIdByName, findRoleIdByNameBody } from "./role.controller"
import { findUserByUsername } from './user.controller';


export const create = (req: Request, res: Response) => {


    Role.findOne({ name: req.body.role }, (err: Error, roleRes: any) => {
        if (err) return res.status(500).send(err);
        else if (!roleRes) return res.status(404).send("Role not found");
        else {
            console.log("ress hedhii : " + roleRes)
            let roleUser = {
                status: 0,
                role: [
                    roleRes._id
                ]
            }
            let user
            if (roleRes.name === "Scooter Owner") {

                user = new User({ name: req.body.name, username: req.body.username, email: req.body.email, password: req.body.password, roles: [{ role: roleRes, status: 1,scooterId: req.body.scooterId }], status: 0 });
            }
            // if (roleRes.name === "Scooter Owner") {
            //     roleUser = {
            //         status: 1,
            //         role: [
            //             roleRes._id
            //         ]
            //     }
            // }
            else {
                user = new User({ name: req.body.name, username: req.body.username, email: req.body.email, password: req.body.password, roles: [{ role: roleRes, status: 0 }], status: 0 });
            }

            console.log(roleUser)
            user.update({ $push: { roles: roleUser } })
            user.save((err, user) => {
                if (err) res.status(500).send(err)
                else res.send(user)
            })

        }
    })

};

export const accept = (req: Request, res: Response) => {
    if ((req.body.isAdmin) || (req.body.isSuperAdmin) || req.body.isSAVManager) {
        let nomRole;

        Role.findOne({ name: req.params.role }).then((role) => {
            nomRole = role
            let idRole = role?._id

            User.updateOne({ username: req.params.username }, { $set: { "roles.$[roles].status": 1 } },
                { arrayFilters: [{ 'roles.role': role?._id }], upsert: true }, function (err, rowsAffected) {
                    if (err) return res.status(500).send(err);
                    else if (!rowsAffected) return res.status(404).send("User not found");
                    else {
                        return res.status(200).send(rowsAffected);
                    }
                })
        });
    }
    else {
        res.status(401).send("You must be a Super Admin or an Admin!")
    }


}
export const refuse = (req: Request, res: Response) => {

    if ((req.body.isAdmin) || (req.body.isSuperAdmin) || req.body.isSAVManager) {
        let nomRole;

        Role.findOne({ name: req.params.role }).then((role) => {
            nomRole = role
            User.updateOne({ username: req.params.username }, { $set: { "roles.$[roles].status": 2 } },
                { arrayFilters: [{ 'roles.role': role?._id }], upsert: true }, function (err, rowsAffected) {
                    if (err) return res.status(500).send(err);
                    else if (!rowsAffected) return res.status(404).send("User not found");
                    else {
                        return res.status(200).send(rowsAffected);
                    }
                })
        });
    }
    else {
        res.status(401).send("You must be a Super Admin or an Admin!")
    }

}

export const updateImage = (req: Request, res: Response) => {
	User.updateOne({ username: req.params.username }, { $set: { image: req.body.image } }, function (err:any, rowsAffected:any) {
		if (err) return res.status(500).send(err);
		else if (!rowsAffected) return res.status(404).send("User not found");
		else {
			return res.status(200).send(rowsAffected);
		}
	});
}
