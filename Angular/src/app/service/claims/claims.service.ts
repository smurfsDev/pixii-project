import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ClaimsService {

  constructor(private _http:HttpClient) { }

  getClaims() {
	return this._http.get('http://localhost:8080/claims');
  }

  getClaim(id:any) {
	return this._http.get('http://localhost:8080/claims/' + id);
	}

  putClaims(claim:any) {
	return this._http.put('http://localhost:8080/claims/'+claim._id, claim);
  }

}
