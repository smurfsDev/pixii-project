import { Request, Response } from 'express';
import Role from "../models/role.model";

export const findAll = (req: Request, res: Response) => {
    const search = req.query.search || '';
    const page: number = parseInt(req.query.page?.toString() || '1');
    const size: number = parseInt(req.query.size?.toString() || '5');

    Role.paginate({
        message: { $regex: ".*(?i)" + search + ".*" },
        subject: { $regex: ".*(?i)" + search + ".*" }
    }, { page: page, limit: size }, (err: any, role: any) => {
        if (err) res.status(500).send(err);
        else res.send(role);
    });

};
// create
export const create = (req: Request, res: Response) => {
    const role = new Role(req.body);

    role.save((err: any) => {
        if (err) return res.status(500).send(err);
        else {
            const role = Role.findByIdAndUpdate(req.body.role, (err: any, role: any) => {
                if (err) return res.status(500).send(err);
                else return res.status(200).send(role);
            });
        };
    })

};

//delete
export const remove = (req: Request, res: Response) => {
    Role.findById(req.params.id, (err: any, role: any) => {
        if (err) return res.status(500).send(err);
        else if (!role) return res.status(404).send("Role not found");
        else {
            role.remove((err: any) => {
                if (err) return res.status(500).send(err);
                else return res.status(200).send(role);
            });
        }
    }
    )
};



// find by id
export const findOne = (req: Request, res: Response) => {
    Role.findById(req.params.id, (err: Error, role: any) => {
        if (err) return res.status(500).send(err);
        else if (!role) return res.status(404).send("Role not found");
        else return res.status(200).send(role);
    })
};


