
import { Request, response, Response } from 'express';
import User from "../models/user.model";
import Role from "../models/role.model";
import roleController, { findRoleIdByName, findRoleIdByNameBody } from "./role.controller"

// export const assignRoleToUser = (req: Request, res: Response) => {
//     const role = req.body.role;
//     const user = new User();

// }

export const create = (req: Request, res: Response) => {

    const role = findRoleIdByNameBody(req.body.role, res)
    console.log(role)

    const user = new User({ name: req.body.name, username: req.body.username, email: req.body.email, password: req.body.password, roles: [req.body.role], status: 0 });
    user.update({ $push: { roles: req.body.role } })
    user.save((err, user) => {
        if (err) res.status(500).send(err)
        else res.send(user)
    })

};
