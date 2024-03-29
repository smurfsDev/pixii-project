import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Store } from '@ngxs/store';
import { ClaimsService } from 'src/app/service/claims/claims.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { BikeDataService } from 'src/app/service/bike/bike-data.service';
import { Bike } from 'src/app/models/bike.model';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { CallbackService } from 'src/app/service/callback/callback.service';

@Component({
  selector: 'app-dash-scooter-owner',
  templateUrl: './dash-scooter-owner.component.html',
  styleUrls: ['./dash-scooter-owner.component.scss']
})
export class DashScooterOwnerComponent implements OnInit {

  authUser: User | undefined;
  title = 'Angular';
  color = '#3DCC93';
  claimSendingLoading = false;
  percentage = 90;
  vehicle = true;
  location = false;
  controlPanel = false;
  locationName = "Location";
  claim = {
    title: "",
    subject: "",
    message: "",
  }
  claimTitle = new FormControl('', [Validators.required, Validators.minLength(3)]);
  claimSubject = new FormControl('', [Validators.required, Validators.minLength(3)]);
  claimMessage = new FormControl('', [Validators.required, Validators.minLength(3)]);

  claimFormGroup: FormGroup;
  constructor(private callback: CallbackService,private _http:HttpClient,private claimService: ClaimsService, private _snackBar: MatSnackBar,private bikeService: BikeDataService,private store: Store) {
    this.claimFormGroup = new FormGroup({
      claimTitle: this.claimTitle,
      claimSubject: this.claimSubject,
      claimMessage: this.claimMessage
    });
  }

  sendCallback(){
	this.callback.sendCallback().subscribe(
		(data:any) => {
			if (data){
				this._snackBar.open("We recieved your callback request, One of our technicians will get to you soon", "OK", {
					duration: 5000,
				});
			}else{
				this._snackBar.open("Callback not created", "OK", {
					duration: 2000,
				});
			}
		}
	);
	}

  async createClaim() {
    this.claimTitle.markAsTouched();
    this.claimSubject.markAsTouched();
    this.claimMessage.markAsTouched();
    if (!this.claimFormGroup.invalid) {
      this.claimSendingLoading = true;
      this.claim.title = this.claimTitle.value!;
      this.claim.subject = this.claimSubject.value!;
      this.claim.message = this.claimMessage.value!;
      const res = await this.claimService.createClaim(this.claim).toPromise();
        if (res) {
          this._snackBar.open("We recieved your claim, One of our technicians will get to you soon", "OK", {
            duration: 10000,
          });
          this.claimFormGroup.reset();
        } else {
          this._snackBar.open("Claim not created", "OK", {
            duration: 2000,
          });
        }
		this.claimSendingLoading = false;
      }
  }

  BikeData: Bike | undefined;

  ngOnInit(): void {
	var authState = this.store.selectSnapshot(state => state.AuthState);

	this.bikeService.getMyBikeData(
		authState["isScooterOwner"].scooterId
	).subscribe((data:Bike) => {
		this.BikeData = data;
		this._http.get(
			`${environment.apiUrl}/node/bike/location/${data.location.latitude}/${data.location.longitude}`,
			{headers: {'X-Requested-With': 'XMLHttpRequest'}}
		).subscribe((data:any) => {
			this.locationName = data[0].local_names.fr?data[0].local_names.fr:data[0].local_names.en?data[0].local_names.en:data[0].name;
		});			
		if (this.BikeData.BatteryHistory.length >0){
			this.percentage = data.BatteryHistory[data.BatteryHistory.length-1].value[1];
		}else{
			this.percentage = 0;
		}
	});
  }
  values(event: any){
    this.vehicle = event.vehicle;
    this.location = event.location;
    this.controlPanel = event.controlPanel;
  }

}
