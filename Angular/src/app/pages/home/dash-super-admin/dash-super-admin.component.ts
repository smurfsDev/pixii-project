import { Component, Input, OnInit } from '@angular/core';
import * as echarts from 'echarts';

@Component({
  selector: 'app-dash-super-admin',
  templateUrl: './dash-super-admin.component.html',
  styleUrls: ['./dash-super-admin.component.scss']
})
export class DashSuperAdminComponent implements OnInit {
    options: any;
    initChart() {
        this.options = {
        xAxis: {
            type: 'category',
            data: ['Done', 'In Progress', 'Pending'],
            name: 'Status',
        },
        yAxis: {
            type: 'value',
            name: 'Number of Claims',
        },
        series: [{
            data: [10, 20, 50],
            type: 'bar',
        }]
        };
    }
    constructor() {
    }

    ngOnInit() {
        this.initChart();
    }

}
