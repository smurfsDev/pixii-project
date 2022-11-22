import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, tap } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  // private _isLoggedIn$ = new BehaviorSubject<boolean>(false);
  // isLoggedIn$ = this._isLoggedIn$.asObservable();



  constructor(private http: HttpClient) {
    // const token = localStorage.getItem('profanis_auth');
    // this._isLoggedIn$.next(!!token);
  }
  login(login: any) {
    return this.http.post(`${environment.apiUrl}/authenticate`, login)
    // .pipe(
    //   tap((response: any) => {
    //     this._isLoggedIn$.next(true);
    //     localStorage.setItem('profanis_auth', response.token);
    //   })
    // );;
  }
}
