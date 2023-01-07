import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate";
let callbackSchema = new mongoose.Schema({
	created: {type: Date, default: Date.now},
	user: {type: mongoose.Schema.Types.ObjectId, ref: "User"},
	called: {type: Boolean, default: false, required: false},
});

callbackSchema.plugin(mongoosePaginate);

const callback = mongoose.model("callbacks", callbackSchema,"callbacks");

export default callback;