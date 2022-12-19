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
}
