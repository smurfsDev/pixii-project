import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class RestpasswordService {
  constructor(private http: HttpClient) {}

  sendtoken(email: any) {
    return this.http.post(`${environment.apiUrl}/forgot_password`, email);
  }
  
  resetpasword(token: any) {
    return this.http.post(`${environment.apiUrl}/reset_password`, token);
  }

}
