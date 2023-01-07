import Comments from "../models/comments.model";
import { Request, Response } from 'express';
import Claim from "../models/claim.model";

export const findAll = (req: Request, res: Response) => {
	const search = req.query.search || '';
	const page: number = parseInt(req.query.page?.toString() || '1');
	const size: number = parseInt(req.query.size?.toString() || '5');

	Comments.paginate({
		message: { $regex: ".*(?i)" + search + ".*" },
		subject: { $regex: ".*(?i)" + search + ".*" }
	}, { page: page, limit: size }, (err: any, comments: any) => {
		if (err) res.status(500).send(err);
		else res.send(comments);
	});

};
// create
export const create = (req: Request, res: Response) => {
		if ((req.body.isSAVManager) || (req.body.isSAVTechnician) || (req.body.isScooterOwner) || (req.body.isSuperAdmin)  ) {
		const comment = new Comments(req.body);

		comment.save((err: any) => {
			if (err) return res.status(500).send(err);
			else {
				const claim = Claim.findByIdAndUpdate(req.body.claim, { $push: { comments: comment._id } }, (err: any, claim: any) => {
					if (err) return res.status(500).send(err);
					else return res.status(200).send(comment);
				});
			};
		})
	}
	else {
		res.status(401).send("You must be an SAV Technician or an SAV Manager or a Scooter Owner!")

	}


};

//delete
export const remove = (req: Request, res: Response) => {
	Comments.findById(req.params.id, (err: any, comment: any) => {
		if (err) return res.status(500).send(err);
		else if (!comment) return res.status(404).send("Comment not found");
		else {
			comment.remove((err: any) => {
				if (err) return res.status(500).send(err);
				else return res.status(200).send(comment);
			});
		}
	}
	)
};

// update
export const update = (req: Request, res: Response) => {
	Comments.findByIdAndUpdate(req.params.id, req.body, (err: any, comment: any) => {
		if (err) return res.status(500).send(err);
		else if (!comment) return res.status(404).send("Comment not found");
		else
			Comments.findById(req.params.id, (err: any, comment: any) => {
				return res.status(200).send(comment);
			});
	})
};

// find by id
export const findOne = (req: Request, res: Response) => {
	Comments.findById(req.params.id, (err: Error, comment: any) => {
		if (err) return res.status(500).send(err);
		else if (!comment) return res.status(404).send("Comment not found");
		else return res.status(200).send(comment);
	})
};


