import { User } from "./user";

export class Callback {
	constructor(
		public _id:string,
		public created:Date,
		public user:User,
		public called:boolean,
	){}
}