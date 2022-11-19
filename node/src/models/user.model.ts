import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate"

let userSchema = new mongoose.Schema({
    username: { type: String, required: true },
    name: { type: String, required: true },
    password: { type: String, required: true },
    // role: { type: String, required: true },
    roles: [{
        type: mongoose.Schema.Types.String,
        ref: "roles",
    }],
    status: {
        type: Number,
        default: true
    }

});

userSchema.plugin(mongoosePaginate)
const User = mongoose.model("User", userSchema)
export default User;