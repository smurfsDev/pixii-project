import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Bike } from 'src/app/models/bike.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class BikeDataService {

  constructor(private _http:HttpClient) { }

  getMyBikeData(id:string):Observable<Bike> {
	return this._http.get(`${environment.apiUrl}/node/bike/${id}`) as Observable<Bike>;
  }

  changeLockState(id:string, state:boolean):Observable<Bike> {
	return this._http.put(`${environment.apiUrl}/node/bike/lock/${id}`, {TheftState:state}) as Observable<Bike>;
  }

  changeLightState(id:string, state:boolean):Observable<Bike> {
	return this._http.put(`${environment.apiUrl}/node/bike/light/${id}`, {LightState:state}) as Observable<Bike>;
  }

  changeAlarmState(id:string, state:boolean):Observable<Bike> {
	return this._http.put(`${environment.apiUrl}/node/bike/alarm/${id}`, {AlarmState:state}) as Observable<Bike>;
  }

}
