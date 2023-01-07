import Callback from "../models/callback.model";
import { Request, Response } from 'express';

export const findAll = async (req: Request, res: Response) => {
	Callback.find(
		{},
		(err: any, statuses: any) => {
			if (err) return res.status(500).send(err);
			else return res.status(200).send(statuses);
		}
	);
};
// create
export const create = (req: Request, res: Response) => {
	const created = new Date();
	req.body.created = created;
	const callback = new Callback(req.body);
	callback.save((err: any) => {
		if (err) return res.status(500).send("Something went wrong");
		else return res.status(200).send(callback);
	})

};

//delete
export const remove = (req: Request, res: Response) => {
	// remove status and all comments
	Callback.findById(req.params.id, (err: any, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Callback not found");
		else {
			status.remove((err: any) => {
				if (err) return res.status(500).send(err);
				else return res.status(200).send(status);
			});
		}
	}
	)
};

// find by id
export const findOne = (req: Request, res: Response) => {
	Callback.findById(req.params.id, (err: Error, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Callback not found");
		else return res.status(200).send(status);
	})
};

export const setCalled = (req: Request, res: Response) => {
	Callback.findByIdAndUpdate(req.params.id, { called: req.params.called }, (err: any, status: any) => {
		if (err) return res.status(500).send(err);
		else if(!status) return res.status(404).send("Callback not found");
		else {
			Callback.findById(req.params.id, (err: any, status: any) => {
				return res.status(200).send(status);
			});
		}
	})
}


