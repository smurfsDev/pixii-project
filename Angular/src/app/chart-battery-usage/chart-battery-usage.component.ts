import { Component, OnInit } from '@angular/core';
import { EChartsOption } from 'echarts';

@Component({
  selector: 'app-chart-battery-usage',
  templateUrl: './chart-battery-usage.component.html',
  styleUrls: ['./chart-battery-usage.component.css']
})
export class ChartBatteryUsageComponent implements OnInit {


  constructor() { }
  ngOnInit(): void {

  }
  // options = {
  //   chart: {
  //     type: 'line'
  //   },
  //   series: [{
  //     name: 'sales',
  //     data: [30, 40, 35, 50, 49, 60, 70, 91, 125]
  //   }],
  //   xaxis: {
  //     categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999]
  //   }
  // }
  chart = "Chart"
  chartOption: EChartsOption = {
    xAxis: {
      type: 'category',
      data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    },
    yAxis: {
      type: 'value',
    },
    series: [
      {
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line',
      },
    ],
  };


  // options: any;
  // updateOptions: any;

  // private oneDay = 24 * 3600 * 1000;
  // private now!: Date;
  // private value!: number;
  // private data!: any[];
  // private timer: any;

  // constructor() { }

  // ngOnInit(): void {
  //   // generate some random testing data:
  //   this.data = [];
  //   this.now = new Date(1997, 9, 3);
  //   this.value = Math.random() * 1000;

  //   for (let i = 0; i < 1000; i++) {
  //     this.data.push(this.randomData());
  //   }

  //   // initialize chart options:
  //   this.options = {
  //     title: {
  //       text: 'Dynamic Data + Time Axis'
  //     },
  //     tooltip: {
  //       trigger: 'axis',
  //       formatter: (params: any) => {
  //         params = params[0];
  //         const date = new Date(params.name);
  //         return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear() + ' : ' + params.value[1];
  //       },
  //       axisPointer: {
  //         animation: false
  //       }
  //     },
  //     xAxis: {
  //       type: 'time',
  //       splitLine: {
  //         show: false
  //       }
  //     },
  //     yAxis: {
  //       type: 'value',
  //       boundaryGap: [0, '100%'],
  //       splitLine: {
  //         show: false
  //       }
  //     },
  //     series: [{
  //       name: 'Mocking Data',
  //       type: 'line',
  //       showSymbol: false,
  //       emphasis: {
  //         line: false,
  //       },
  //       data: this.data
  //     }]
  //   };

  //   // Mock dynamic data:
  //   this.timer = setInterval(() => {
  //     for (let i = 0; i < 5; i++) {
  //       this.data.shift();
  //       this.data.push(this.randomData());
  //     }

  //     // update series data:
  //     this.updateOptions = {
  //       series: [{
  //         data: this.data
  //       }]
  //     };
  //   }, 1000);
  // }

  // ngOnDestroy() {
  //   clearInterval(this.timer);
  // }

  // randomData() {
  //   this.now = new Date(this.now.getTime() + this.oneDay);
  //   this.value = this.value + Math.random() * 21 - 10;
  //   return {
  //     name: this.now.toString(),
  //     value: [
  //       [this.now.getFullYear(), this.now.getMonth() + 1, this.now.getDate()].join('/'),
  //       Math.round(this.value)
  //     ]
  //   };
  // }

}
