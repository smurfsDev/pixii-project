import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private _http:HttpClient) { }
  getClaimsByStatus() {
          return this._http.get(`${environment.apiUrl}/node/dashboard/claimsByStatus`);
  }
  getUsers() {
          return this._http.get(`${environment.apiUrl}/node/dashboard/users`);
  }
  getBikes() {
          return this._http.get(`${environment.apiUrl}/node/dashboard/bikes`);
  }
  getMineClaims() {
          return this._http.get(`${environment.apiUrl}/node/dashboard/mineClaims`);
  }

}
