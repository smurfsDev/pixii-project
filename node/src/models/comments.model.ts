import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate";
let commentsSchema = new mongoose.Schema({
	message: {type: String, required: true},
	created: {type: Date, default: Date.now},
	user: {type: mongoose.Schema.Types.ObjectId, ref: "User"},
	claim: {
		type: mongoose.Schema.Types.ObjectId,
		ref: "claims",
		required: true
	}
});

commentsSchema.plugin(mongoosePaginate);

commentsSchema.pre("remove", function(next) {
	mongoose.model("claims").findByIdAndUpdate(this.claim, { $pull: { comments: this._id } }, (err: any, claim: any) => {
		if (err) return next(err);
	});
	next();
});
const comment = mongoose.model("comments", commentsSchema,"comments");

export default comment;