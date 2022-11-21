import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class RegisterService {

  constructor(private http: HttpClient) { }
  register(register: any) {
      return  this.http.post(`${environment.apiUrl}/register`, register);
  }

  fetchRoles() {
    return this.http.get(`${environment.apiUrl}/roles`);
  }

  checkEmail(email: string) {
    return this.http.get(`${environment.apiUrl}/checkEmail/${email}`);
  }

  checkUserName(userName: string) {
    return this.http.get(`${environment.apiUrl}/checkUsername/${userName}`);
  }

  verifyAccount(token: any) {
    return this.http.post(`${environment.apiUrl}/verify`, token);
  }



}
