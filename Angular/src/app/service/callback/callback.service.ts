import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Callback } from 'src/app/models/callback.model';
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

  changeCallbackCalledStatus(id:string, status:boolean){
	return this._http.put(`${environment.apiUrl}/node/callback/${id}`, {called:status});
  }
  

}
