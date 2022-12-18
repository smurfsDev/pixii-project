
import { Request, Response } from 'express';
import User from "../models/user.model";
import Role from "../models/role.model";
import roleController, { findRoleIdByName, findRoleIdByNameBody } from "./role.controller"


export const create = (req: Request, res: Response) => {


    Role.findOne({ name: req.body.role }, (err: Error, role: any) => {
        if (err) return res.status(500).send(err);
        else if (!role) return res.status(404).send("Role not found");
        else {
            const user = new User({ name: req.body.name, username: req.body.username, email: req.body.email, password: req.body.password, roles: [role], status: 0 });
            user.update({ $push: { roles: role } })
            user.save((err, user) => {
                if (err) res.status(500).send(err)
                else res.send(user)
            })

        }
    })

};
