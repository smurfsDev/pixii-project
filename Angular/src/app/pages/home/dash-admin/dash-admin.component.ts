import { Component, Input, OnInit } from '@angular/core';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Callback } from 'src/app/models/callback.model';
import { CallbackService } from 'src/app/service/callback/callback.service';
import { DashboardService } from 'src/app/service/dashboard/dashboard.service';

@Component({
	selector: 'app-dash-admin',
	templateUrl: './dash-admin.component.html',
	styleUrls: ['./dash-admin.component.scss']
})
export class DashAdminComponent implements OnInit {

	@Input() options: any;
	@Input() claimsByStatus: any;
	@Input() percentage = 0;
	@Input() bikes = 0;
	@Input() savManagers = 0;
	@Input() savTechnicians = 0;
	@Input() scooterOwners = 0;

	callbacks: Callback[] = [];

	constructor(private callback: CallbackService, private snackbar: MatSnackBar, public dialog: MatDialog) { }

	ngOnInit(): void {
		this.fetchCallbacks();
	}

	fetchCallbacks() {
		this.callbacks = [];
		this.callback.getCallbacks().subscribe((data: any) => {
			data.forEach((callback: any) => {
				if(callback.called == false){
					this.callbacks.push(callback);
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
			}else{
				this.snackbar.open('Callback status not changed', 'Close', {
					duration: 3000,
					verticalPosition: 'bottom',
					horizontalPosition: 'right'
				});
			}
		});
	}



}

@Component({
	selector: 'called-dialog',
	templateUrl: './called-dialog.component.html',
})
export class CalledDialogComponent {
	constructor(public dialogRef: MatDialogRef<CalledDialogComponent>) { }
	onClick(choice: string): void {
		this.dialogRef.close(choice);
	}
}

