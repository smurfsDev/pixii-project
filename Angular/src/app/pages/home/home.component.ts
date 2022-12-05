import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Store } from '@ngxs/store';
import { ClaimsService } from 'src/app/service/claims/claims.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']

})
export class HomeComponent implements OnInit {

  authUser: User | undefined;
  title = 'Angular';
  color = '#3DCC93';
  percentage = 90;
  claim = {
    title: "",
    subject: "",
    message: "",
  }
  claimTitle = new FormControl('', [Validators.required, Validators.minLength(3)]);
  claimSubject = new FormControl('', [Validators.required, Validators.minLength(3)]);
  claimMessage = new FormControl('', [Validators.required, Validators.minLength(3)]);

  claimFormGroup: FormGroup;
  constructor(private claimService: ClaimsService, private _snackBar: MatSnackBar) {
    this.claimFormGroup = new FormGroup({
      claimTitle: this.claimTitle,
      claimSubject: this.claimSubject,
      claimMessage: this.claimMessage
    });
  }

  createClaim() {
    this.claimTitle.markAsTouched();
    this.claimSubject.markAsTouched();
    this.claimMessage.markAsTouched();
    if (!this.claimFormGroup.invalid) {
      this.claim.title = this.claimTitle.value!;
      this.claim.subject = this.claimSubject.value!;
      this.claim.message = this.claimMessage.value!;
      this.claimService.createClaim(this.claim).subscribe((data: any) => {
        if (data) {
          this._snackBar.open("We recieved your claim, One of our technicians will get to you soon", "OK", {
            duration: 10000,
          });
          this.claimFormGroup.reset();
        } else {
          this._snackBar.open("Claim not created", "OK", {
            duration: 2000,
          });
        }
      });
    }
  }

  ngOnInit(): void {


  }


}
