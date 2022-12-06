import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Store } from '@ngxs/store';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class HasRoleGuard implements CanActivate {
  constructor(private store:Store, private router:Router) {}
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot,
  ):
    | Observable<boolean | UrlTree>
    | Promise<boolean | UrlTree>
    | boolean
    | UrlTree {
    var roles = [];
    var isAuthorized = false;
    for (var role in this.store.selectSnapshot(state => state.AuthState.user).role) {
      roles.push(this.store.selectSnapshot(state => state.AuthState.user).role[role].name);
    }
    for (var routeRole in route.data['role']){
      if (roles.includes(route.data['role'][routeRole]) && this.store.selectSnapshot(state => state.AuthState.user).status=="1") {
        isAuthorized = true;
        break;
      }
    }
    if (!isAuthorized) {
      window.alert('you are not authorized');
      this.router.navigate(['claims']);

    }
    return isAuthorized || false;
  }

}
