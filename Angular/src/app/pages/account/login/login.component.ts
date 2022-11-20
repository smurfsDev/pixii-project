import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import { User } from 'src/app/models/user';
import { LoginService } from 'src/app/service/account/login.service';
import { Store } from '@ngxs/store';
import { SetIsAuthenticated, SetToken, SetUser } from 'src/app/store/auth/actions';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  hide = true;
  loginForm : FormGroup;
  user : User = new User( '','','','',null);
  username = new FormControl('', [Validators.required, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,10}$')]);
  password = new FormControl('', [Validators.required,
                                  Validators.minLength(8),
                                  Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
                                ]);
  getEmailErrorMessage() {
    if (this.username.touched) {
      if (this.username.hasError('required')) {
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
  constructor(private formBuilder: FormBuilder , private LoginService: LoginService, private store: Store)
     {
    this.loginForm = this.formBuilder.group({
      username: this.username,
      password: this.password
    });
  }

  ngOnInit(): void {
    // error messages of the form hide
    localStorage.clear();
    // this.store.dispatch([
    //   new SetToken('Ahaha'),
    //   new SetUser(new User("1", "youssef", "email", "role")),
    //   new SetIsAuthenticated(true)
    // ]);

  }
  onSubmit() {
    if (this.loginForm.valid) {
      this.LoginService.login(this.loginForm.value).subscribe((data: any) => {
        console.log(data);
        this.user = data;
        this.store.dispatch([
          new SetToken(data.token),
          new SetUser(new User(data.user.id, data.user.username, data.user.name, data.user.email, data.user.roles)),
          new SetIsAuthenticated(true)
        ]);
      }, (error: any) => {
        console.log(error);
      }
      );
    }
    else {
      console.log('invalid');
      this.username.markAsTouched();
      this.password.markAsTouched();
    }
    }

}
