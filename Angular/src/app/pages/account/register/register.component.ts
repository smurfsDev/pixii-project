import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormControl, ValidationErrors, ValidatorFn, Validators} from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  hide = true;
  hideConfirm = true;
  email = new FormControl('', [Validators.required, Validators.email]);
  userName = new FormControl('', [Validators.required, Validators.minLength(3), Validators.maxLength(20)]);
  password = new FormControl('', [Validators.required, Validators.minLength(8), Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$'), this.checkPassword('ConfirmPassword', false)]);
  ConfirmPassword = new FormControl('', [Validators.required, this.checkPassword('password')]);
  checkPassword(matchTo: string,reverse?: boolean): ValidatorFn {
    return (control: AbstractControl):
    ValidationErrors | null => {
      if (control.parent && reverse) {
        const c = (control.parent?.controls as any)[matchTo] as AbstractControl;
        if (c) {
          c.updateValueAndValidity();
        }
        return null;
      }
      return !!control.parent &&
        !!control.parent.value &&
        control.value ===
        (control.parent?.controls as any)[matchTo].value
        ? null
        : { matching: true };
    };
  }
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

  constructor() { }

  ngOnInit(): void {
  }

}
