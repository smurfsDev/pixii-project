import { User } from "./user";

export class Claim {
	constructor(
		public _id:String,
		public title:String,
		public message:String,
		public subject:String,
		public created:Date,
		public updated:Date,
		public status: String,
		public author: User,
	){}
}