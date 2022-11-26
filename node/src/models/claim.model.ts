import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate";
import comments from "./comments.model";
import User from "./user.model";


let claimsSchema = new mongoose.Schema({
	subject: { type: String, required: true },
	message: { type: String, required: true },
	created: { type: Date, default: Date.now },
	comments: [{
		type: mongoose.Schema.Types.ObjectId,
		ref: "comments"
	}],
	status: {
		type: mongoose.Schema.Types.ObjectId,
		ref: "status",
	},
	_status: [
		{
			old_status: {
				type: mongoose.Schema.Types.ObjectId,
				ref: "status",
			},
			new_status: {
				type: mongoose.Schema.Types.ObjectId,
				ref: "status",
			},
			author: {
				type: mongoose.Schema.Types.ObjectId,
				ref: "users",
			},
			date: { type: Date, default: Date.now },
		}
	],
	updated: { type: Date, default: Date.now }
});


claimsSchema.plugin(mongoosePaginate);

claimsSchema.pre("findOneAndUpdate", async function (next) {
	// @ts-ignore
	const author = this.getUpdate()?.author;
	// @ts-ignore
	const newStatus = this.getUpdate()?.status;

	try {
		const item:any = await this.model.findOne(this.getQuery());
		const user = await User.findOne({ email: author.email }).exec();
		item.updated = Date.now();
		item.save();
		
		const currentStatus = item.status;
		if (newStatus && currentStatus) {
			if (newStatus != currentStatus) {
				item._status.push({ old_status: currentStatus, new_status: newStatus, date: Date.now(), author: user!._id });
			}
		}
	} catch (error) {
		console.log(error);
	}

	next();
});

claimsSchema.post("findOneAndUpdate", async function () {
	const item = await this.model.findOne(this.getQuery());
	item.updated = Date.now();
	item.save();
});


claimsSchema.pre("remove", function (next) {
	this.comments.forEach((comment: any) => {
		comments.findByIdAndRemove(comment, (err: any) => {
			if (err) return next(err);
		});
	});
	next();
});

const claim = mongoose.model("claims", claimsSchema, "claims");

export default claim;