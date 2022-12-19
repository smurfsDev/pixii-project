import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate"

let userSchema = new mongoose.Schema({
    username: { type: String, required: true },
    name: { type: String, required: true },
    email: { type: String, required: true },
    password: { type: String, required: true },
    // role: { type: String, required: true },
    roles: [
        {
            role: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "roles",
            },
            status: {
                type: Number,
                required: true,
                default: 0
            }
        },

    ],
    status: {
        type: Number,
        default: 0
    },
    // roles: [
    //     {
    //         type: mongoose.Schema.Types.ObjectId,
    //         ref: "Roles"
    //     }
    // ]

});

userSchema.plugin(mongoosePaginate)
const User = mongoose.model("User", userSchema)
export default User;