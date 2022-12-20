
import { Request, Response } from 'express';
import User from "../models/user.model";
import Role from "../models/role.model";
import roleController, { findRoleIdByName, findRoleIdByNameBody } from "./role.controller"
import { findUserByUsername } from './user.controller';


export const create = (req: Request, res: Response) => {


    Role.findOne({ name: req.body.role }, (err: Error, role: any) => {
        if (err) return res.status(500).send(err);
        else if (!role) return res.status(404).send("Role not found");
        else {
            console.log(role)
            const user = new User({ name: req.body.name, username: req.body.username, email: req.body.email, password: req.body.password, roles: [role], status: 0 });
            user.update({ $push: { roles: role } })
            user.save((err, user) => {
                if (err) res.status(500).send(err)
                else res.send(user)
            })

        }
    })

};

export const accept = (req: Request, res: Response) => {
    let nomRole;

    Role.findOne({ name: req.params.role }).then((role) => {
        console.log(role)
        nomRole = role
        console.log(role?._id)
        let idRole = role?._id

        User.updateOne({ username: req.params.username }, { $set: { "roles.$[roles].status": 1 } },
            { arrayFilters: [{ 'roles._id': role?._id }], upsert: true }, function (err, rowsAffected) {
                if (err) return res.status(500).send(err);
                else if (!rowsAffected) return res.status(404).send("User not found");
                else {
                    console.log(rowsAffected)
                    return res.status(200).send(rowsAffected);
                }
            })
    });
}
export const refuse = (req: Request, res: Response) => {
    let nomRole;

    Role.findOne({ name: req.params.role }).then((role) => {
        console.log(role)
        nomRole = role
        console.log(role?._id)
        User.updateOne({ username: req.params.username }, { $set: { "roles.$[roles].status": 2 } },
            { arrayFilters: [{ 'roles._id': role?._id }], upsert: true }, function (err, rowsAffected) {
                if (err) return res.status(500).send(err);
                else if (!rowsAffected) return res.status(404).send("User not found");
                else {
                    // console.log(rowsAffected)
                    return res.status(200).send(rowsAffected);
                }
            })
    });
}
