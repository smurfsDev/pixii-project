import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(private http: HttpClient) { }
  login(login: any) {
    return this.http.post(`http://localhost:8081/authenticate`, login);
  }
}
