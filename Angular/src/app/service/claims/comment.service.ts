import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  constructor(private http:HttpClient) { }

  comment(comment: any) {
	return this.http.post(`http://localhost:8080/comments`, comment);
  }

}
