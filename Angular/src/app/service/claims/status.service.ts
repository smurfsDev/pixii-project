import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class StatusService {

  constructor(private _http:HttpClient) { }

  getStatus() {
	return this._http.get('http://localhost:8080/status');
  }
}
