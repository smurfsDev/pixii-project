import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Store } from '@ngxs/store';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class HttpInterceptorService implements HttpInterceptor{

  constructor(private store:Store) { }

	intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
		req = req.clone({
			setHeaders: {
				Authorization: `Bearer ${this.store.selectSnapshot(state => state.AuthState.token)}`
			}
		});

		req = req.clone({
			setHeaders: {
				AutorizationNode: `${this.store.selectSnapshot(state => state.AuthState.user.email)}`
			}
		});
	
		return next.handle(req); 
	}
}
