import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class StatusService {

  constructor(private _http:HttpClient) { }

  getStatus() {
	return this._http.get(`${environment.apiUrl}/node/status`);
  }
}
