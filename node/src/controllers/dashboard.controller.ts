import Claim from "../models/claim.model";
import { Request, Response } from 'express';
import status from "../models/status.model";
import User from "../models/user.model";
import Role from "../models/role.model";
import Bike from "../models/bike.model";
export const CountClaimsByStatus = (req: Request, res: Response) => {
    Claim.aggregate([
        {
            $group: {
                _id: "$status",
                count: { $sum: 1 }
            }
        }
    ]).then((claims) => {
        status.populate(claims, { path: "_id" }, function (err, claims) {
            res.send(claims);
        });
    });
}
export const CountUsersByRole = (req: Request, res: Response) => {
    User.aggregate([
        {
            $unwind: "$roles"
        },
        {
            $group: {
                _id: "$roles",
                count: { $sum: 1 }
            }
        }
    ]).then((users) => {
            res.send(users);
    });
}
export const CountBikes = (req: Request, res: Response) => {
    Bike.countDocuments().then((bikes) => {
        res.send({ bikes });
    });
}
// count mine claims
export const CountMineClaims = (req: Request, res: Response) => {
    Claim.countDocuments({ technician: req.body.user }).then((claims) => {
        res.send({ claims });
    });
}