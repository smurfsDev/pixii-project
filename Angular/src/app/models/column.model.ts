import { Claim } from "./claim.model";

export class Column {
	constructor(public name: string, public id: string, public tasks: Claim[]) {}
  }
  