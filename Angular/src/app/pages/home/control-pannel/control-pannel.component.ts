import { Component, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Store } from '@ngxs/store';
import { Bike } from 'src/app/models/bike.model';
import { BikeDataService } from 'src/app/service/bike/bike-data.service';
import { ClaimsService } from 'src/app/service/claims/claims.service';
@Component({
	selector: 'app-control-pannel',
	templateUrl: './control-pannel.component.html',
	styleUrls: ['./control-pannel.component.scss']
})
export class ControlPannelComponent implements OnInit {

	constructor(private claimService: ClaimsService, private _snackBar: MatSnackBar, private bikeService: BikeDataService, private store: Store) { }
	BikeData: Bike | undefined;
	IsLocked: boolean = false;
	IsAlarm: boolean = false;
	IsLight: boolean = false;

	ngOnInit(): void {
		var authState = this.store.selectSnapshot(state => state.AuthState);

		this.bikeService.getMyBikeData(
			authState["isScooterOwner"].scooterId
		).subscribe((data: Bike) => {
			this.BikeData = data;
			console.log(this.BikeData);
			this.IsAlarm = this.BikeData?.AlarmState;
			this.IsLocked = this.BikeData?.TheftState;
			this.IsLight = this.BikeData?.LightState;
		});
	}

	LockBike(state: boolean) {
		this.bikeService.changeLockState(this.BikeData!.id, state).subscribe((data: Bike) => {
			console.log(data);
			this.IsLocked = data.TheftState;
		}
		);
	}

	AlarmBike(state: boolean) {
		this.bikeService.changeAlarmState(this.BikeData!.id, state).subscribe((data: Bike) => {
			console.log(data);
			this.IsAlarm = data.AlarmState;
		}
		);
	}

	LightBike(state: boolean) {
		this.bikeService.changeLightState(this.BikeData!.id, state).subscribe((data: Bike) => {
			console.log(data);
			this.IsLight = data.LightState;
		}
		);
	}



}
