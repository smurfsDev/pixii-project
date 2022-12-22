import { Injectable } from '@angular/core';
import { Action, Selector, State, StateContext } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { SetIsAuthenticated, SetToken, SetUser, LogoutAction } from "./actions";

export interface IsScooterOwner {
	isScooterOwner: boolean;
	scooterId: string|null;
}
export class AuthStateModel {
	isAuthenticated: boolean = false;
	token: string | null | undefined;
	user: User | null | undefined;
	isAdmin: boolean = false;
	isSuperAdmin: boolean = false;
	isSAVManager: boolean = false;
	isSAVTechnician: boolean = false;
	isScooterOwner: IsScooterOwner = {
		isScooterOwner: false,
		scooterId: null
	};
}

@State<AuthStateModel>({
	name: 'AuthState',
	defaults: {
		isAuthenticated: false,
		token: null,
		user: null,
		isAdmin: false,
		isSuperAdmin: false,
		isSAVManager: false,
		isSAVTechnician: false,
		isScooterOwner: {
			isScooterOwner: false,
			scooterId: null
		},
	}
})
@Injectable()
export class AuthState {
@Selector()
	static getIsAuthenticated({ isAuthenticated }: AuthStateModel) {
		return isAuthenticated;
	}

	@Selector()
	static getToken({ token }: AuthStateModel) {
		return token;
	}

	@Selector()
	static getUser({ user }: AuthStateModel) {
		return user;
	}

	@Selector()
	static getIsAdmin({ isAdmin }: AuthStateModel) {
		return isAdmin;
	}

	@Selector()
	static getIsSuperAdmin({ isSuperAdmin }: AuthStateModel) {
		return isSuperAdmin;
	}

	@Selector()
	static getIsSAVManager({ isSAVManager }: AuthStateModel) {
		return isSAVManager;
	}

	@Action(SetToken)
	setToken({ getState, patchState }: StateContext<AuthStateModel>, { payload }: SetToken) {
		patchState({
			token: payload
		});
	}
	@Action(SetUser)
	setUser({ getState, patchState }: StateContext<AuthStateModel>, { payload }: SetUser) {
		patchState({
			user: payload,
			isAdmin: payload?.role.find((r:any)=>r.name == "Admin" && r.status == 1)?true:false,
			isSuperAdmin: payload?.role.find((r:any)=>r.name == "Super Admin" && r.status == 1)?true:false,
			isSAVManager: payload?.role.find((r:any)=>r.name == "SAV Manager" && r.status == 1)?true:false,
			isSAVTechnician: payload?.role.find((r:any)=>r.name == "SAV Technician" && r.status == 1)?true:false,
			isScooterOwner: payload?.role.find((r:any)=>r.name == "Scooter Owner" )?{isScooterOwner: true, scooterId: payload?.role.find((r:any)=>r.name == "Scooter Owner" )?.bike_id}: {isScooterOwner: false, scooterId: null}
		});
	}

	@Action(SetIsAuthenticated)
	setIsAuthenticated({ getState, patchState }: StateContext<AuthStateModel>, { payload }: SetIsAuthenticated) {
		patchState({
			isAuthenticated: payload
		});
	}

	@Action(LogoutAction)
	logout({ getState, patchState }: StateContext<AuthStateModel>) {
		patchState({
			isAuthenticated: false,
			token: null,
			user: null,
		});
	}
}
