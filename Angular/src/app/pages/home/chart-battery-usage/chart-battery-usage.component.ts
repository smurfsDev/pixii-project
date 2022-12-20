import { Component, OnInit, Input, OnChanges, SimpleChanges } from '@angular/core';
import { EChartsOption } from 'echarts';

@Component({
	selector: 'app-chart-battery-usage',
	templateUrl: './chart-battery-usage.component.html',
	styleUrls: ['./chart-battery-usage.component.css']
})
export class ChartBatteryUsageComponent implements OnInit, OnChanges {

	options: any;
	updateOptions: any;

	@Input() data: { name: Date, value: [Date, number] }[] | any[] = [];

	constructor() { }
	ngOnChanges(changes: SimpleChanges): void {
		this.initChart();
	}

	ngOnInit(): void {
		this.initChart();
	}

	initChart() {
		this.options = {
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
				},
			},
			yAxis: {
				type: 'value',
				boundaryGap: [0, '100%'],
				splitLine: {
					show: false
				},
				max:100,
			},
			series: [{
				name: 'Battery',
				type: 'line',
				showSymbol: false,
				emphasis: {
					line: false,
				},
				data: this.data
			}]
		};
	}


}
