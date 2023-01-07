import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { toInteger } from '@ng-bootstrap/ng-bootstrap/util/util';
import { Store } from '@ngxs/store';
import * as echarts from 'echarts';
import { Callback } from 'src/app/models/callback.model';
import { CallbackService } from 'src/app/service/callback/callback.service';
import { DashboardService } from 'src/app/service/dashboard/dashboard.service';
import { CalledDialogComponent } from '../dash-admin/dash-admin.component';

@Component({
	selector: 'app-dash-super-admin',
	templateUrl: './dash-super-admin.component.html',
	styleUrls: ['./dash-super-admin.component.scss']
})
export class DashSuperAdminComponent implements OnInit {

	@Input() options: any;
	@Input() claimsByStatus: any;
	@Input() percentage = 0;
	@Input() bikes = 0;
	@Input() admins = 0;
	@Input() savManagers = 0;
	@Input() savTechnicians = 0;
	@Input() scooterOwners = 0;

	myName: string = '';

	pendingCallbacks: Callback[] = [];
	doneCallbacks: Callback[] = [];
	myAnsweredCallbacks: Callback[] = [];

	constructor(private store: Store, private callback: CallbackService, private snackbar: MatSnackBar, public dialog: MatDialog) { }

	ngOnInit(): void {
		this.store.select(state => state.AuthState).subscribe(user => {
			this.myName = user.user.name;
		});

		this.fetchCallbacks();
	}

	fetchCallbacks() {
		this.doneCallbacks = [];
		this.pendingCallbacks = [];
		this.myAnsweredCallbacks = [];
		this.callback.getCallbacks().subscribe((data: any) => {
			data.forEach((callback: any) => {
				var callerName: string | null = callback?.caller?.name;
				if (callback.called == false) {
					this.pendingCallbacks.push(callback);
				} else {
					if (callerName && callerName?.replace(" ","").toLowerCase() == this.myName.toLowerCase()) {
						this.myAnsweredCallbacks.push(callback);
					}

					this.doneCallbacks.push(callback);
				}
			});
		});
	}


	changeCallbackCalledStatus(id: string, status: boolean) {
		this.dialog.open(CalledDialogComponent,
		).afterClosed().subscribe((choice: string) => {
			if (choice == 'yes') {
				this.callback.changeCallbackCalledStatus(id, status).subscribe((data: any) => {
					this.fetchCallbacks();
					this.snackbar.open('Callback status changed', 'Close', {
						duration: 3000,
						verticalPosition: 'bottom',
						horizontalPosition: 'right'
					});
				});
			} else {
				this.snackbar.open('Callback status not changed', 'Close', {
					duration: 3000,
					verticalPosition: 'bottom',
					horizontalPosition: 'right'
				});
			}
		});
	}


}
