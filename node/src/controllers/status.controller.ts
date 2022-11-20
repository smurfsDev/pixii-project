import Status from "../models/status.model";
import { Request, Response } from 'express';

export const findAll = async (req: Request, res: Response) => {
	Status.find(
		{},
		(err: any, statuses: any) => {
			if (err) return res.status(500).send(err);
			else return res.status(200).send(statuses);
		}
	);
};
// create
export const create = (req: Request, res: Response) => {
	const status = new Status(req.body);
	status.save((err: any) => {
		if (err) return res.status(500).send("Something went wrong");
		else return res.status(200).send(status);
	})

};

//delete
export const remove = (req: Request, res: Response) => {
	// remove status and all comments
	Status.findById(req.params.id, (err: any, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Status not found");
		else {
			status.remove((err: any) => {
				if (err) return res.status(500).send(err);
				else return res.status(200).send(status);
			});
		}
	}
	)
};

// update
export const update = (req: Request, res: Response) => {
	Status.findByIdAndUpdate(req.params.id, req.body, (err: any, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Status not found");
		else Status.findById(req.params.id, (err: any, status: any) => {
			return res.status(200).send(status);
		});
	})
};

// find by id
export const findOne = (req: Request, res: Response) => {
	Status.findById(req.params.id, (err: Error, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Status not found");
		else return res.status(200).send(status);
	})
};

export const setStatus = (req: Request, res: Response) => {
	Status.findByIdAndUpdate(req.params.id, { status: req.params.status }, (err: any, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Status not found");
		else {
			Status.findById(req.params.id, (err: any, status: any) => {
				return res.status(200).send(status);
			});
		}
	})
}


