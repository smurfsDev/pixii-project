import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RegisterService {

  constructor(private http:HttpClient) { }
  register(register: any) {
      return  this.http.post(`http://localhost:8080/register`, register);
  }
  
  fetchRoles() {
    return this.http.get(`http://localhost:8080/roles`);
  }

  checkEmail(email: string) {
	return this.http.get(`http://localhost:8080/checkEmail/${email}`);
  }

  checkUserName(userName: string) {
	return this.http.get(`http://localhost:8080/checkUsername/${userName}`);
  }

  

}
