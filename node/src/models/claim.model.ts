import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate";
import comments from "./comments.model";
let claimsSchema = new mongoose.Schema({
	subject: {type: String, required: true},
	message: {type: String, required: true},
	status: {type: Number, required: true, default: 0},
	created: {type: Date, default: Date.now},
	comments: [{
		type: mongoose.Schema.Types.ObjectId,
		ref: "comments"
	}]
});

claimsSchema.plugin(mongoosePaginate);

claimsSchema.pre("remove", function(next) {
	this.comments.forEach((comment: any) => {
		comments.findByIdAndRemove(comment, (err: any) => {
			if (err) return next(err);
		});
	});
	next();
});

const claim = mongoose.model("claims", claimsSchema,"claims");

export default claim;