
import { Request, Response } from 'express';
import User from "../models/user.model";
import Role from "../models/role.model";
import roleController, { findRoleIdByName } from "./role.controller"

// export const findAll = (req: Request, res: Response) => {
//     const search = req.query.search || '';
//     const page: number = parseInt(req.query.page?.toString() || '1');
//     const size: number = parseInt(req.query.size?.toString() || '5');

//     User.paginate({
//         message: { $regex: ".*(?i)" + search + ".*" },
//         subject: { $regex: ".*(?i)" + search + ".*" }
//     }, { page: page, limit: size }, (err: any, users: any) => {
//         if (err) res.status(500).send(err);
//         else res.send(users);
//     });

// };
// create
export const create = (req: Request, res: Response) => {

    // const role = Role.find({ name: req.params });
    // console.log(role)
    // return res.status(200).send(role);
    // const role = findRoleIdByName(req.params.role)
    const user = new User(req.body);
    // user.roles = role.findRoleIdByName 
    // console.log(user);
    user.save((err, user) => {
        if (err) res.status(500).send(err)

        else res.send(user)
    })
    // user.save((err: any) => {
    //     // if (err) return res.status(500).send(err);
    //     // else {
    //     const user = User.findByIdAndUpdate(req.body.user, (err: any, user: any) => {
    //         if (err) return res.status(500).send(err);
    //         else return res.status(200).send(user);
    //     });
    //     // };
    // })

};
