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
  email = new FormControl('', [Validators.required, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,10}$')]);
  userName = new FormControl('', [Validators.required, Validators.minLength(3), Validators.maxLength(20)]);
  password = new FormControl('', [Validators.required, Validators.minLength(8),
                                  Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
                                  ,checkPassword('ConfirmPassword', true)]);
  ConfirmPassword = new FormControl('', [Validators.required,checkPassword('password')]);
  role = new FormControl('', [Validators.required]);
  getEmailErrorMessage() {
    if (this.email.touched) {
      if (this.email.hasError('required')) {
        return 'You must enter a value';
      }
      return 'Not a valid email';
    }
    return '';
  }
  getUserNameErrorMessage() {
    if (this.userName.touched) {
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
      else if (this.password.hasError('matching')) {
        return 'Passwords do not match';
      }
      return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
    }
    return '';
  }
  getConfirmPasswordErrorMessage() {
    if (this.ConfirmPassword.touched) {
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
    return '';
  }
  getRoleErrorMessage() {
    if (this.role.touched) {
      if (this.role.hasError('required')) {
        return 'You must enter a value';
      }
      return 'Not a valid role';
    }
    return '';
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
    //submit the form if it is valid
    if (this.registerForm.valid) {
      console.log(this.registerForm.value);
    }
    else {
      console.log('Form is invalid');
      this.email.markAsTouched();
      this.userName.markAsTouched();
      this.password.markAsTouched();
      this.ConfirmPassword.markAsTouched();
    }
  }

}
