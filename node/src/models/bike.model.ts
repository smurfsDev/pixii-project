
import mongoose from "mongoose";
import mongoosePaginate from "mongoose-paginate"

let BikeDataSchema = new mongoose.Schema({
	id: { type: String, required: true },
	SysPower: { type: Boolean, required: true },
	date: { type: Date, required: true },
	location: {
		latitude: { type: Number, required: true },
		longitude: { type: Number, required: true },
		altitude: { type: Number, required: true },
		heading: { type: Number, required: true },
		speed: { type: Number, required: true },
		accuracy: { type: Number, required: true },
	},
	BatteryStatus: { type: Boolean, required: true },
	BatteryCap: { type: Number, required: true },
	BatteryHistory: [
		{
			value:[
			],
			name:{ type: Date, required: true },

		}
	],
	Range: { type: Number, required: true },
	BluetoothOp: { type: Boolean, required: true },
	BluetoothCon: { type: Boolean, required: true },
	TheftState: { type: Boolean, required: true },
	SystemSOS: { type: Boolean, required: true },
	UserSOS: { type: Boolean, required: true },
	LightState: { type: Boolean, required: true },
	AlarmState: { type: Boolean, required: true },
});

BikeDataSchema.plugin(mongoosePaginate)
const BikeData = mongoose.model("bikeData", BikeDataSchema)
export default BikeData;