import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { RestpasswordService } from 'src/app/service/account/restpassword.service';
import { checkPassword } from '../form-validators';
import { validator } from '../auth/validator';

@Component({
  selector: 'app-reset-password',
  templateUrl: './reset-password.component.html',
  styleUrls: ['./reset-password.component.scss'],
})
export class ResetPasswordComponent implements OnInit {
  loading = false;
  resetpassword: FormGroup;

  email = new FormControl('', [
    Validators.required,
    Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$'),
  ]);

  token = new FormControl('', [
    Validators.required,
    Validators.minLength(8),
    Validators.maxLength(8),
  ]);

  password = new FormControl('', [
    Validators.required,
    Validators.minLength(8),
    Validators.maxLength(20),
    Validators.pattern('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$'),
    checkPassword('cpassword', true),
  ]);

  cpassword = new FormControl('', [
    Validators.required,
    checkPassword('password'),
  ]);

  constructor(
    private router: Router,
    private formBuilder: FormBuilder,
    private restpasswordService: RestpasswordService,
    private _snackBar: MatSnackBar
  ) {
    this.resetpassword = this.formBuilder.group({
      email: this.email,
      token: this.token,
      password: this.password,
      cpassword: this.cpassword,
    });
  }

  onSubmit() {
    if (this.resetpassword.valid) {
      this.loading = true;
      this.restpasswordService
        .resetpasword({
          email: this.resetpassword.value.email,
          token: this.resetpassword.value.token,
          password: this.resetpassword.value.password,
        })

        .subscribe(
          (data) => {
            this._snackBar.open('Password restored', 'close', {
              duration: 2000,
            });
            this.loading = false;
            setTimeout(() => {
              this.router.navigate(['/auth']);
            }, 2000);
          },
          (error) => {
            this._snackBar.open(error.error.message ?? 'Error', 'close', {
              duration: 2000,
            });
            this.loading = false;
          },
          () => {
            this.loading = false;
          }
        );
    } else {
      this._snackBar.open("Password doesn't match", 'close', {
        duration: 2000,
      });
    }
  }
  ngOnInit(): void {}
}
