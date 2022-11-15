import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate";
import comments from "./comments.model";
let statusSchema = new mongoose.Schema({
	name: {type: String, required: true},
	created: {type: Date, default: Date.now},
	claims: [{
		type: mongoose.Schema.Types.ObjectId,
		ref: "claims",
	}]
});

statusSchema.plugin(mongoosePaginate);
const status = mongoose.model("status", statusSchema,"status");

export default status;