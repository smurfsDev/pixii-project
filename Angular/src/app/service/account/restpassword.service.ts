import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class RestpasswordService {
  constructor(private http: HttpClient) {}

  sendtoken(email: any) {
    return this.http.post(`http://localhost:8081/forgot_password`, email);
  }
  
  resetpasword(token: any) {
    return this.http.post(`http://localhost:8081/reset_password`, token);
  }

}
