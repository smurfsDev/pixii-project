import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class ProfileService {
  constructor(private http: HttpClient) {}

  getProfile() {
    return this.http.get(`${environment.apiUrl}/getprofile`);
  }

  getScooterName() {
    return this.http.get(`${environment.apiUrl}/gscootername`);
  }

  updateProfile(data: any) {
    return this.http.put(`${environment.apiUrl}/profilemodify`, data);
  }

  updatePassword(data: any) {
    return this.http.put(`${environment.apiUrl}/changepassword`, data);
  }

  updateScooterName(data: any) {
    return this.http.put(`${environment.apiUrl}/scootername`, data);
  }

  uploadProfilePicture(data: any) {
    return this.http.post(`${environment.apiUrl}/upload`, data);
  }

  getProfilePicture() {
    return this.http.get(`${environment.apiUrl}/getimage`);
  }
}
