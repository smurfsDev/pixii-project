import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import { ErrorStateMatcher } from '@angular/material/core';
import { checkPassword } from '../form-validators';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  registerForm: FormGroup;
  hide = true;
  hideConfirm = true;
  email = new FormControl('', [Validators.required, Validators.email]);
  userName = new FormControl('', [Validators.required, Validators.minLength(3), Validators.maxLength(20)]);
  password = new FormControl('', [Validators.required, Validators.minLength(8),
                                  Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
                                  ,checkPassword('ConfirmPassword', true)]);
  ConfirmPassword = new FormControl('', [Validators.required,checkPassword('password')]);
  getEmailErrorMessage() {
    if (this.email.hasError('required')) {
      return 'You must enter a value';
    }
    return this.email.hasError('email') ? 'Not a valid email' : '';
  }
  getUserNameErrorMessage() {
    if (this.userName.hasError('required')) {
      return 'You must enter a value';
    }
    else if (this.userName.hasError('minlength')) {
      return 'Username must be at least 3 characters';
    }
    else if (this.userName.hasError('maxlength')) {
      return 'Username must be at most 20 characters';
    }
    return 'Username must contain only letters and numbers';
  }
  getPasswordErrorMessage() {
    if (this.password.hasError('required')) {
      return 'You must enter a value';
    }
    else if (this.password.hasError('minlength')) {
      return 'Password must be at least 8 characters';
    }
    else if (this.password.hasError('matching')) {
      return 'Passwords do not match';
    }
    return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
  }
  getConfirmPasswordErrorMessage() {
    if (this.ConfirmPassword.hasError('required')) {
      return 'You must enter a value';
    }
    else if (this.ConfirmPassword.hasError('minlength')) {
      return 'Password must be at least 8 characters';
    }
    else if (this.ConfirmPassword.hasError('matching')) {
      return 'Passwords do not match';
    }
    return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
  }

  constructor( private formBuilder: FormBuilder) {
    this.registerForm = this.formBuilder.group({
      email: this.email,
      userName: this.userName,
      password: this.password,
      ConfirmPassword: this.ConfirmPassword
    }, {validator: checkPassword('password')});

  }

  ngOnInit(): void {
  }
  onSubmit() {
    console.log(this.registerForm.value);
  }

}
