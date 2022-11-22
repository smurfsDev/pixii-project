import { Injectable } from "@angular/core";
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from "@angular/router";
import { Observable, tap } from "rxjs";
import { LoginService } from "./service/account/login.service";
import { RegisterService } from "./service/account/register.service";

@Injectable({
    providedIn: 'root'
})

export class IsAuthenticatedGuard implements CanActivate {

    constructor(private loginService: LoginService, private router: Router) { }
    canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean | UrlTree | Observable<boolean | UrlTree> | Promise<boolean | UrlTree> {
        return true

        // return localStorage.getItem("")
    }
}