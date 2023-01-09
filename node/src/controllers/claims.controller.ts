import Claim from "../models/claim.model";
import { Request, Response } from 'express';
import status from "../models/status.model";
import User from "../models/user.model";
import { fetchUser } from "../configs/auth.config";

export const findAll = async (req: Request, res: Response) => {
	// const search = req.query.search || '';
	// const page: number = parseInt(req.query.page?.toString() || '1');
	// const size: number = parseInt(req.query.size?.toString() || '5');

	// // paginate search and populate comments
	// Claim.paginate({ subject: { $regex: search, $options: 'i' } }, { page, limit: size, populate: ['comments', 'status'] })
	// 	.then((claims) => {
	// 		res.send(claims);
	// 	}
	// 	);
	Claim.find().populate("_status").populate('status', 'name').then((claims) => {
		res.send(claims);
	});
};

// get mine
export const findAffectedToMe = async (req: Request, res: Response) => {
	if (req.body.isSAVTechnician || req.body.isSAVManager || req.body.isSuperAdmin) {
		Claim.find({ technician: req.body.user }).populate("_status").populate('status', 'name').then((claims) => {
			res.send(claims);
		});
	}
	else {
		res.status(403).send("You must be a isSAVManager || isSAVTechnician || isSuperAdmin !")

	}

};

// get mine
export const findMine = async (req: Request, res: Response) => {
	// const user =
	if (req.body.isScooterOwner) {
		Claim.find({ user: req.body.user }).populate("_status").populate('status').then((claims) => {
			res.send(claims);
		});
	}
	else {
		res.status(403).send("You must be a Scooter Owner!")

	}

};

// create
export const create = (req: Request, res: Response) => {
	if (req.body.isScooterOwner) {
		const claim = new Claim(req.body);
		if (!req.body.status) {
			status.findOne({ name: 'TODO' }, (err: any, status: any) => {
				if (!status) {
					status = new status({ name: 'TODO' }, (err: any, status: any) => {
						if (err) return res.status(500).send("Something went wrong");
						else {
							claim.$set({ status: status._id });
							claim.save((err: any) => {
								if (err) return res.status(500).send("Something went wrong" + err.message);
								else return res.status(200).send(claim);
							})
						}
					}
					);
				} else {
					claim.$set({ status: status._id });
					claim.save((err: any) => {
						if (err) return res.status(500).send("Something went wrong" + err.message);
						else return res.status(200).send(claim);
					})
				}
			});
		} else {
			claim.save((err: any) => {
				if (err) return res.status(500).send("Something went wrong" + err.message);
				else return res.status(200).send(claim);
			})
		}
	}
	else {
		res.status(403).send("You must be an Scooter Owner!")
	}

};
//delete
export const remove = (req: Request, res: Response) => {
	// remove claim and all comments
	if (req.body.isScooterOwner) {
		Claim.findById(req.params.id, (err: any, claim: any) => {
			if (err) return res.status(500).send(err);
			else if (!claim) return res.status(404).send("Claim not found");
			else {
				claim.remove((err: any) => {
					if (err) return res.status(500).send(err);
					else return res.status(200).send(claim);
				});
			}
		}
		)
	}
	else {
		res.status(403).send("You must be an Sccoter Owner!")

	}

};

// update
export const update = (req: Request, res: Response) => {
	if (req.body.isSAVTechnician || req.body.isSAVManager || req.body.isSuperAdmin) {
		Claim.findByIdAndUpdate(req.params.id, { ...req.body, author: req.body.user.email }, (err: any, claim: any) => {
			if (err) return res.status(500).send(err);
			else if (!claim) return res.status(404).send("Claim not found");
			else Claim.findById(req.params.id, (err: any, claim: any) => {
				return res.status(200).send(claim);
			});
		})
	}
	else {
		res.status(403).send("You must be a isSAVManager || isSAVTechnician || isSuperAdmin!")

	}
};

// find by id
export const findOne = (req: Request, res: Response) => {

	Claim.findById(req.params.id, (err: Error, claim: any) => {
		if (err) return res.status(500).send(err);
		else if (!claim) return res.status(404).send("Claim not found");
		else return res.status(200).send(claim);
	}).populate('status', 'name')
		.populate('user', 'name')
		.populate('technician', 'name')
		.populate({
			path: 'comments',
			populate: {
				path: 'user',
				model: 'User',
			}
		})
		.populate({
			path: "_status",
			populate: [
				{
					path: "old_status",
					model: "status"
				},
				{
					path: "new_status",
					model: "status"
				},
				{
					path: "author",
					select: "name image",
					model: "User"
				}
			]
		}).populate({
			path: "_technician",
			populate: [
				{
					path: "old_technician",
					model: "User"
				},
				{
					path: "new_technician",
					model: "User"
				},
				{
					path: "author",
					select: "name image",
					model: "User"
				}
			]
		});
};

export const setStatus = (req: Request, res: Response) => {
	if ((req.body.isSAVManager) || (req.body.isSAVTechnician || req.body.isSuperAdmin)) {
		Claim.findByIdAndUpdate(req.params.id, { status: req.params.status, author: req.body.user.email }, (err: any, claim: any) => {
			if (err) return res.status(500).send(err);
			else if (!claim) return res.status(404).send("Claim not found");
			else {
				Claim.findById(req.params.id, (err: any, claim: any) => {
					return res.status(200).send(claim);
				});
			}
		})
	}
	else {
		res.status(403).send("You must be an SAV Technician or an SAV Manager or isSuperAdmin!")

	}

}

export const affectClaimToTechnician = async (req: Request, res: Response) => {
	if (req.body.isSAVManager || req.body.isSuperAdmin) {
		const technician = await User.findById(req.params.technician);
		Claim.findByIdAndUpdate(req.params.id, { technician: technician, author: req.body.user.email }, (err: any, claim: any) => {
			if (err) return res.status(
				500).send(err);
			else if (!claim) return res.status(404).send("Claim not found");
			else {
				Claim.findById(req.params.id, (err: any, claim: any) => {
					return res.status(200).send(claim);
				});
			}
		})
	}
	else {
		res.status(403).send("You must be an SAV Manager or isSuperAdmin!")
	}

}

