import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ClaimsService {

  constructor(private _http:HttpClient) { }

  getClaims() {
	return this._http.get(`${environment.apiUrl}/node/claims`);
  }

  getClaimsAffectedToMe() {
	return this._http.get(`${environment.apiUrl}/node/claims/affectedToMe`);
	}	

  getClaim(id:any) {
	return this._http.get(`${environment.apiUrl}/node/claims/` + id);
	}

  putClaims(claim:any) {
	return this._http.put(`${environment.apiUrl}/node/claims/`+claim._id, claim);
  }

}
