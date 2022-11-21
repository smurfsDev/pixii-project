import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { RegisterService } from 'src/app/service/account/register.service';
import { validator } from '../auth/validator';

@Component({
	selector: 'app-verify-email',
	templateUrl: './verify-email.component.html',
	styleUrls: ['./verify-email.component.scss']
})
export class VerifyEmailComponent implements OnInit {

	constructor(private router: Router ,private formBuilder: FormBuilder, private myValid: validator, private registerService: RegisterService, private _snackBar: MatSnackBar) {
		this.verifyEmailForm = this.formBuilder.group({
			email: this.email,
			code: this.code,
		});
	}

	verifyEmailForm: FormGroup;
	email = new FormControl('', [Validators.required,
	Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$')
	],
		//   this.myValid.userValidator()
	);

	code = new FormControl('', [Validators.required, Validators.minLength(8), Validators.maxLength(8)]);

	onSubmit() {
		this.registerService.verifyAccount({
			email: this.verifyEmailForm.value.email,
			code: this.verifyEmailForm.value.code
		}).subscribe(
			(data) => {
				this._snackBar.open('Account verified', 'close', {
					duration: 2000,
				});
				setTimeout(() => {
					this.router.navigate(['/auth']);
				}, 2000);
			},
			(error) => {
				this._snackBar.open(error.error.message??"Error", 'close', {
					duration: 2000,
				});
			}

		);

	}

	ngOnInit(): void {
	}

}
