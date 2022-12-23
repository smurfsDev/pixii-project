import mongoose from 'mongoose';

const uri = process.env.MONGODB_CONN||'mongodb://localhost:27017/ProjetIntegration';
export const connect = () => {
	mongoose.connect(uri,(err) => {
		if (err) {
			console.log(err.message);
		} else {
			console.log("Successfully Connected!");
		}
		
	});
}
