import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Store } from '@ngxs/store';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class HasRoleGuard implements CanActivate {
  constructor(private store:Store) {}
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ):
    | Observable<boolean | UrlTree>
    | Promise<boolean | UrlTree>
    | boolean
    | UrlTree {
    var roles = [];
    for (var role in this.store.selectSnapshot(state => state.AuthState.user).role) {
      roles.push(this.store.selectSnapshot(state => state.AuthState.user).role[role].name);
    }
    const isAuthorized = roles.includes(route.data['role']);
    console.log('isAuthorized', isAuthorized);
    console.log('route.data[role]', roles);
    if (!isAuthorized) {
      window.alert('you are not authorized');
    }

    return isAuthorized || false;
  }

}
