import { Component, Input, OnInit } from '@angular/core';
import { DashboardService } from 'src/app/service/dashboard/dashboard.service';

@Component({
  selector: 'app-dash-sa-vtechnicien',
  templateUrl: './dash-sa-vtechnicien.component.html',
  styleUrls: ['./dash-sa-vtechnicien.component.scss']
})
export class DashSaVTechnicienComponent implements OnInit {

    @Input() options: any;
    @Input() percentage = 0;
    @Input() bikes= 0;
    @Input() scooterOwners = 0;
    myClaims = 0;
    ngOnInit(): void {
    }
    constructor(private dashboardService: DashboardService) {}
    getMineClaims() {
        this.dashboardService.getMineClaims().subscribe((res: any) => {
            this.myClaims = res.claims;
        });
    }


}
