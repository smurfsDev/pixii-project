import { User } from "src/app/models/user";

export class SetToken {
	static readonly type = '[Auth] SetToken';

	constructor(public payload: string | null) {
	}
}

export class SetUser {
	static readonly type = '[Auth] SetUser';

	constructor(public payload: User | null) {
	}
}

export class SetIsAuthenticated {
	static readonly type = '[Auth] SetIsAuthenticated';
	constructor(public payload: boolean) {
	}
}
