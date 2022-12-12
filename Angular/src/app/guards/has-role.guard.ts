import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Store } from '@ngxs/store';
import { Observable } from 'rxjs';

@Injectable({
	providedIn: 'root'
})
export class HasRoleGuard implements CanActivate {
	constructor(private store: Store, private router: Router) { }
	canActivate(
		route: ActivatedRouteSnapshot,
		state: RouterStateSnapshot,
	):
		| Observable<boolean | UrlTree>
		| Promise<boolean | UrlTree>
		| boolean
		| UrlTree {

		var isAuthorized = false;
		var authState = this.store.selectSnapshot(state => state.AuthState);
		
		for (var rid in route.data['role']) {
			var r = route.data['role'][rid];
			if (authState["is" + r[0].toUpperCase() + r.slice(1).replace(" ", "")]) {
				isAuthorized = true;
				break;
			}
		}
		if (!isAuthorized) {
			window.alert('you are not authorized');
			this.router.navigate(['/']);

		}
		return isAuthorized || false;
	}

}
