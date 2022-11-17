import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import { LoginService } from 'src/app/service/account/login.service';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  hide = true;
  loginForm : FormGroup;
  email = new FormControl('', [Validators.required, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,10}$')]);
  password = new FormControl('', [Validators.required,
                                  Validators.minLength(8),
                                  Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
                                ]);
  getEmailErrorMessage() {
    if (this.email.touched) {
      if (this.email.hasError('required')) {
        return 'You must enter a value';
      }
      return 'Not a valid email';
    }
    return '';
  }
  getPasswordErrorMessage() {
    if (this.password.touched) {
      if (this.password.hasError('required')) {
        return 'You must enter a value';
      }
      else if (this.password.hasError('minlength')) {
        return 'Password must be at least 8 characters';
      }
        return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
    }
    return '';
    }
  constructor(private formBuilder: FormBuilder , private LoginService: LoginService) {
    this.loginForm = this.formBuilder.group({
      email: this.email,
      password: this.password
    });
  }

  ngOnInit(): void {
    // error messages of the form hide

  }
  onSubmit() {
    if (this.loginForm.valid) {
      this.LoginService.login(this.loginForm.value).subscribe((data: any) => {
        console.log(data);
      }, (error: any) => {
        console.log(error);
      }
      );
    }
    else {
      console.log('invalid');
      this.email.markAsTouched();
      this.password.markAsTouched();
    }
    }

}
