import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AbstractControl, AsyncValidatorFn } from '@angular/forms';
import { Observable, timer } from 'rxjs';
import { map, switchMap } from 'rxjs/operators';
import { RegisterService } from 'src/app/service/account/register.service';


@Injectable({
	providedIn: 'root'
})
export class validator {
	constructor(private registerService: RegisterService, private http: HttpClient) { }

	searchUserByEmail(email: string) {
		return timer(1000)
			.pipe(
				switchMap(() => {
					// Check if username is available
					return this.registerService.checkEmail(email);
				})
			);
	}

	userValidator(): AsyncValidatorFn {
		return (control: AbstractControl):any => {
			return this.searchUserByEmail(control.value)
				.pipe(
					map((res:any) => {
						if (!res) {
							// return error
							return { 'emailExist': true };
						}
						return null;
					})
				);
		};
	}

	searchUserByUserName(userName: string) {
		return timer(1000)
			.pipe(
				switchMap(() => {
					return this.registerService.checkUserName(userName);
				})
			);
	}

	userNameValidator(): AsyncValidatorFn {
		return (control: AbstractControl):any => {
			return this.searchUserByUserName(control.value)
				.pipe(
					map((res:any) => {
						console.log(res);
						if (!res) {
							// return error
							return { 'userNameExists': true };
						}
						return null;
					})
				);
		};
	}

}
