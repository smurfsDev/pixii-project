import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ManageUsersService {

  constructor(private http: HttpClient) { }
  fetchUsers() {
    return this.http.get(`${environment.apiUrl}/users`);
  }
  fetchRoles() {
    return this.http.get(`${environment.apiUrl}/roles`);
  }
  acceptUser(idUser : number,idRole : number) {
    return this.http.get(`${environment.apiUrl}/accept/${idUser}/${idRole}`);
  }
  rejectUser(idUser : number,idRole : number) {
    return this.http.get(`${environment.apiUrl}/reject/${idUser}/${idRole}`);
  }

}
