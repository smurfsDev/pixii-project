import { Injectable } from '@angular/core';
import { Action, Selector, State, StateContext } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { SetIsAuthenticated, SetToken, SetUser, LogoutAction } from "./actions";

export class AuthStateModel {
	isAuthenticated: boolean = false;
	token: string | null | undefined;
	user: User | null | undefined;
	isAdmin: boolean = false;
	isSuperAdmin: boolean = false;
	isSavManager: boolean = false;
	isSavTechnician: boolean = false;
	isScooterOwner: boolean = false;
}

@State<AuthStateModel>({
	name: 'AuthState',
	defaults: {
		isAuthenticated: false,
		token: null,
		user: null,
		isAdmin: false,
		isSuperAdmin: false,
		isSavManager: false,
		isSavTechnician: false,
		isScooterOwner: false,
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
	static getIsSavManager({ isSavManager }: AuthStateModel) {
		return isSavManager;
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
			isSavManager: payload?.role.find((r:any)=>r.name == "SAV Manager" && r.status == 1)?true:false,
			isSavTechnician: payload?.role.find((r:any)=>r.name == "SAV Technician" && r.status == 1)?true:false,
			isScooterOwner: payload?.role.find((r:any)=>r.name == "Scooter Owner" && r.status == 1)?true:false,
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
