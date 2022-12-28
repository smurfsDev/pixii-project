import { Component, Input, OnInit } from '@angular/core';
import { toInteger } from '@ng-bootstrap/ng-bootstrap/util/util';
import * as echarts from 'echarts';
import { DashboardService } from 'src/app/service/dashboard/dashboard.service';

@Component({
  selector: 'app-dash-super-admin',
  templateUrl: './dash-super-admin.component.html',
  styleUrls: ['./dash-super-admin.component.scss']
})
export class DashSuperAdminComponent implements OnInit {

    @Input() options: any;
    @Input() claimsByStatus: any;
    @Input() percentage = 0;
    @Input() bikes= 0;
    @Input() admins = 0;
    @Input() savManagers = 0;
    @Input() savTechnicians = 0;
    @Input() scooterOwners = 0;
    ngOnInit(): void {
    }

}
