import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { RegisterService } from 'src/app/service/account/register.service';
import { validator } from '../auth/validator';

@Component({
  selector: 'app-resend-verification',
  templateUrl: './resend-verification.component.html',
  styleUrls: ['./resend-verification.component.scss']
})
export class ResendVerificationComponent implements OnInit {

	constructor(private router: Router ,private formBuilder: FormBuilder, private myValid: validator, private registerService: RegisterService, private _snackBar: MatSnackBar) {
		this.verifyEmailForm = this.formBuilder.group({
			email: this.email,
		});
	}

	loading = false;
	verifyEmailForm: FormGroup;
	email = new FormControl('', [Validators.required,
	Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$')
	],
	);


	onSubmit() {
		this.loading = true;
		this.registerService.resendVerificationEmail({
			email: this.verifyEmailForm.value.email,
		}).subscribe(
			(data) => {
				this._snackBar.open('New verification token sent', 'verify', {
					duration: 2000,
				}).onAction().subscribe(() => {
					this.router.navigate(['/verify']);
				});
				this.loading = false;
				setTimeout(() => {
					this.router.navigate(['/verify']);
				}, 2000);
				
			},
			(error) => {
				this._snackBar.open(error.error.message??"Error", 'close', {
					duration: 2000,
				});
				this.loading = false;
			},
			() => {
				this.loading = false;
			}

		);

	}

	ngOnInit(): void {
	}


}
