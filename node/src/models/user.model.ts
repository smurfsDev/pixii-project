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
            role: [
                {
                    type: mongoose.Schema.Types.ObjectId,
                    ref: "roles",
                }
            ],


            status: {
                type: Number,
                required: true,
                default: 0
            },

			scooterId: {
				type: String,
				required: false,
			}
        },

    ],
    status: {
        type: Number,
        default: 0
    },
    image: {
		type: String,
		required: false,
	},

});

userSchema.plugin(mongoosePaginate)
const User = mongoose.model("User", userSchema)
export default User;