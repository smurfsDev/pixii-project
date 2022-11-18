import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate"

let userSchema = new mongoose.Schema({
    username: { type: String, required: true },
    name: { type: String, required: true },
    password: { type: String, required: true },
    role: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "roles",
    }]

});

userSchema.plugin(mongoosePaginate)
const User = mongoose.model("User", userSchema)
export default User;