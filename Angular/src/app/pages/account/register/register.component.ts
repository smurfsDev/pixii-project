import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import { ErrorStateMatcher } from '@angular/material/core';
import { checkPassword } from '../form-validators';
import { RegisterService } from 'src/app/service/account/register.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
})
export class RegisterComponent implements OnInit {
  registerForm: FormGroup;
  hide = true;
  hideConfirm = true;
  roles: any = [];

  email = new FormControl('', [Validators.required, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,10}$')]);
  userName = new FormControl('', [Validators.required, Validators.minLength(3), Validators.maxLength(20)]);
  password = new FormControl('', [Validators.required, Validators.minLength(8),
                                  Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
                                  ,checkPassword('ConfirmPassword', true)]);
  ConfirmPassword = new FormControl('', [Validators.required,checkPassword('password')]);
  roleInput = new FormControl('', [Validators.required]);
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
    if (this.roleInput.touched) {
      if (this.roleInput.hasError('required')) {
        return 'You must enter a value';
      }
      return 'Not a valid role';
    }
    return '';
  }
  constructor( private formBuilder: FormBuilder, private RegisterService: RegisterService , private router: Router) {
    this.registerForm = this.formBuilder.group({
      email: this.email,
      name: this.userName,
      password: this.password,
      role: this.roleInput,
      confirmPassword: this.ConfirmPassword
    });

  }

  ngOnInit(): void {
    this.fetchRoles();
  }
  onSubmit() {
    if (this.registerForm.valid) {
      this.RegisterService.register(this.registerForm.value).subscribe((data: any) => {
        console.log(data);
        this.router.navigate(['/login']);
      });
      this.ConfirmPassword.reset();
    }
    else {
      console.log('Form is invalid');
      this.email.markAsTouched();
      this.userName.markAsTouched();
      this.password.markAsTouched();
      this.ConfirmPassword.markAsTouched();
      this.roleInput.markAsTouched();
    }
  }
  fetchRoles() {
    this.RegisterService.fetchRoles().subscribe((data: any) => {
      this.roles = data.roles;
      console.log(this.roles);
    }
    );
  }

}
