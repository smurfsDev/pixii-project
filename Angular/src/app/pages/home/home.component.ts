import { Component, OnInit } from '@angular/core';

import { Store } from '@ngxs/store';
import { DashboardService } from 'src/app/service/dashboard/dashboard.service';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']

})
export class HomeComponent implements OnInit {
  isSuperAdmin: boolean = false;
  isAdmin: boolean = false;
  isSavManager: boolean = false;
  isSavTechnician: boolean = false;
  isScooterOwner: boolean = false;
  isAuth: boolean = false;
    options: any;
    claimsByStatus: any;
    xAxisData = new Map([]);
    claimsDone = 0;
    totalClaims = 0;
    percentage = 0;
    bikes= 0;
    admins = 0;
    savManagers = 0;
    savTechnicians = 0;
    scooterOwners = 0;
    initChart() {
        this.options = {
        xAxis: {
            type: 'category',
            data: Array.from(this.xAxisData.keys()),

            name: 'Status',
        },
        yAxis: {
            type: 'value',
            name: 'Number of Claims',
        },
        series: [{
            data: Array.from(this.xAxisData.values()),
            type: 'bar',
        }]
        };
    }
  constructor(private store: Store,private dashboardService: DashboardService) {
    this.store.select(state => state.AuthState).subscribe(user => {
      if (user) {
        this.isSuperAdmin = user.isSuperAdmin;
        this.isAdmin = user.isAdmin;
        this.isSavManager = user.isSAVManager;
        this.isSavTechnician = user.isSAVTechnician;
        this.isScooterOwner = user['isScooterOwner'].isScooterOwner;
        this.isAuth = user.isAuthenticated;
      }
    });
  }
  ngOnInit() {
    this.getClaimsByStatus();
    this.getBikes();
    this.getUsers();
}
getClaimsByStatus() {
    this.dashboardService.getClaimsByStatus().subscribe((res: any) => {
        this.claimsByStatus = res;
        for (let i = 0; i < this.claimsByStatus.length; i++) {
            this.xAxisData.set(this.claimsByStatus[i]._id.name, this.claimsByStatus[i].count);
            if (this.claimsByStatus[i]._id.name == "DONE") {
                this.claimsDone = this.claimsByStatus[i].count;
            }
            this.totalClaims += this.claimsByStatus[i].count;
        }
        this.initChart();
        this.percentage = (this.claimsDone / this.totalClaims) * 100;
    }
    );
}
getBikes() {
    this.dashboardService.getBikes().subscribe((res: any) => {
        this.bikes = res.bikes;
    });
}
getUsers() {
    this.dashboardService.getUsers().subscribe((res: any) => {
        console.log(res);
        for(let i in res) {
            if(res[i]._id.name == "Admin") {
                this.admins = res[i].count;
            }
            if(res[i]._id.name == "SAV Manager") {
                this.savManagers = res[i].count;
            }
            if(res[i]._id.name == "SAV Technician") {
                this.savTechnicians = res[i].count;
            }
            if(res[i]._id.name == "Scooter Owner") {
                this.scooterOwners = res[i].count;
            }
        }

    });
}

}
