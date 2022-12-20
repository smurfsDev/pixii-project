import { Component, OnInit, OnDestroy, Input, OnChanges, SimpleChanges } from '@angular/core';
import { EChartsOption } from 'echarts';

@Component({
  selector: 'app-chart-battery-usage',
  templateUrl: './chart-battery-usage.component.html',
  styleUrls: ['./chart-battery-usage.component.css']
})
export class ChartBatteryUsageComponent implements OnInit, OnDestroy,OnChanges {

  options: any;
  updateOptions: any;

  private oneDay = 24 * 3600 * 1000;
  private now!: Date;
  private value!: number;
  @Input()  data: { name: Date, value: [Date, number] }[]|any[] = [];
  private timer: any;

  constructor() { }
	ngOnChanges(changes: SimpleChanges): void {
		this.options = {
			title: {
			  // text: 'Battery Usage'
			},
			tooltip: {
			  trigger: 'axis',
			  formatter: (params: any) => {
				params = params[0];
				const date = new Date(params.name);
				return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear() + ' : ' + params.value[1];
			  },
			  axisPointer: {
				animation: false
			  }
			},
			xAxis: {
			  type: 'time',
			  splitLine: {
				show: false
			  }
			},
			yAxis: {
			  type: 'value',
			  boundaryGap: [0, '100%'],
			  splitLine: {
				show: false
			  },
			  max: 100,
			},
			series: [{
			  name: 'Mocking Data',
			  type: 'line',
			  showSymbol: false,
			  emphasis: {
				line: false,
			  },
			  data: this.data
			}]
		  };
	}

  ngOnInit(): void {
    // generate some random testing data:
    // this.data = [];
    // this.now = new Date(2020, 4, 30);
    // this.value = Math.random() * 100;

    // for (let i = 0; i < 100; i++) {
    //   this.data.push(this.randomData());
    // }

    // initialize chart options:
    this.options = {
      title: {
        // text: 'Battery Usage'
      },
      tooltip: {
        trigger: 'axis',
        formatter: (params: any) => {
          params = params[0];
          const date = new Date(params.name);
          return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear() + ' : ' + params.value[1];
        },
        axisPointer: {
          animation: false
        }
      },
      xAxis: {
        type: 'time',
        splitLine: {
          show: false
        }
      },
      yAxis: {
        type: 'value',
        boundaryGap: [0, '100%'],
        splitLine: {
          show: false
        }
      },
      series: [{
        name: 'Mocking Data',
        type: 'line',
        showSymbol: false,
        emphasis: {
          line: false,
        },
        data: this.data
      }]
    };

    // // Mock dynamic data:
    // this.timer = setInterval(() => {
    //   for (let i = 0; i < 5; i++) {
    //     this.data.shift();
    //     this.data.push(this.randomData());
    //   }

    //   // update series data:
    //   this.updateOptions = {
    //     series: [{
    //       data: this.data
    //     }]
    //   };
    // }, 1000);
  }

  ngOnDestroy() {
    clearInterval(this.timer);
  }

  randomData() {
    this.now = new Date(this.now.getTime() + this.oneDay);
    this.value = this.value + Math.random() * 21 - 10;
    return {
      name: this.now.toString(),
      value: [
        [this.now.getFullYear(), this.now.getMonth() + 1, this.now.getDate()].join('/'),
        Math.round(this.value)
      ]
    };
  }


}
