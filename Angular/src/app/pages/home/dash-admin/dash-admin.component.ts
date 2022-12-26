import { Component, Input, OnInit } from '@angular/core';
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
    @Input() bikes= 0;
    @Input() savManagers = 0;
    @Input() savTechnicians = 0;
    @Input() scooterOwners = 0;
    ngOnInit(): void {
    }


}
