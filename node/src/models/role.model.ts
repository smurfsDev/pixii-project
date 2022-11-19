import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate"

let roleSchema = new mongoose.Schema({

    name: { type: String, required: true },
    // users: [
    //     {
    //         type: mongoose.Schema.Types.ObjectId,
    //         ref: "users",
    //     },

    // ],
    // status: {
    //     type: Boolean,
    //     default: true
    // }

});

roleSchema.plugin(mongoosePaginate)
const Role = mongoose.model("Role", roleSchema)
export default Role;