import { Component, OnInit } from '@angular/core';
import {FormBuilder,FormControl,FormGroup,Validators,} from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { RestpasswordService } from 'src/app/service/account/restpassword.service';

@Component({
  selector: 'app-checkemail',
  templateUrl: './checkemail.component.html',
  styleUrls: ['./checkemail.component.scss'],
})
export class CheckemailComponent implements OnInit {
  loading = false;
  sendtoken: FormGroup;

  email = new FormControl('', [
    Validators.required,
    Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$'),
  ]);

  constructor(
    private router: Router,
    private formBuilder: FormBuilder,
    private restpasswordService: RestpasswordService,
    private _snackBar: MatSnackBar
  ) {
    this.sendtoken = this.formBuilder.group({
      email: this.email,
    });
  }

onSubmit() {
    this.loading = true;
    this.restpasswordService
      .sendtoken({
        email: this.sendtoken.value.email,
      })
      .subscribe(
        (data) => {
          this._snackBar.open('Token sent', 'close', {
            duration: 2000,
          });
          this.loading = false;
          setTimeout(() => {
            this.router.navigate(['/reset-password']);
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
  }

  ngOnInit(): void {}
}
