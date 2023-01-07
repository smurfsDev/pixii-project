import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CallbackService {

  constructor(private _http:HttpClient) { }

  sendCallback(){
	return this._http.post(`${environment.apiUrl}/node/callback`,{});
  }

  getCallbacks(){
	return this._http.get(`${environment.apiUrl}/node/callback`);
  }
  

}
