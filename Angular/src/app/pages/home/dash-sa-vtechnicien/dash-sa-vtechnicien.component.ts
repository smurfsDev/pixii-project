import { Component, OnInit } from '@angular/core';
import { DashboardService } from 'src/app/service/dashboard/dashboard.service';

@Component({
  selector: 'app-dash-sa-vtechnicien',
  templateUrl: './dash-sa-vtechnicien.component.html',
  styleUrls: ['./dash-sa-vtechnicien.component.scss']
})
export class DashSaVTechnicienComponent implements OnInit {

  options: any;
  claimsByStatus: any;
  xAxisData = new Map([]);
  claimsDone = 0;
  totalClaims = 0;
  percentage = 0;
  myClaims = 0;
  bikes= 0;
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
  constructor(private dashboardService: DashboardService) {
  }

  ngOnInit() {
      this.getClaimsByStatus();
      this.getBikes();
      this.getMineClaims();
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
  getMineClaims() {
      this.dashboardService.getMineClaims().subscribe((res: any) => {
          this.myClaims = res.claims;
      });
  }


}
