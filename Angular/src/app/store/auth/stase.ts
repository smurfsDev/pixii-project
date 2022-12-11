import { Injectable } from '@angular/core';
import { Action, Selector, State, StateContext } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { SetIsAuthenticated, SetToken, SetUser, LogoutAction } from "./actions";

export class AuthStateModel {
	isAuthenticated: boolean = false;
	token: string | null | undefined;
	user: User | null | undefined;
}

@State<AuthStateModel>({
	name: 'AuthState',
	defaults: {
		isAuthenticated: false,
		token: null,
		user: null,
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

	@Action(SetToken)
	setToken({ getState, patchState }: StateContext<AuthStateModel>, { payload }: SetToken) {
		patchState({
			token: payload
		});
	}
@Action(SetUser)
	setUser({ getState, patchState }: StateContext<AuthStateModel>, { payload }: SetUser) {
		patchState({
			user: payload
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
