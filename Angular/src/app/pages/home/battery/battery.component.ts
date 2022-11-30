import { Component, Input, OnInit } from '@angular/core';

@Component({
	selector: 'app-battery',
	templateUrl: './battery.component.html',
	styleUrls: ['./battery.component.scss']
})
export class BatteryComponent implements OnInit {
	
	@Input() percentage: number = 80;
	constructor() { }

	batteryClasses() {
		return {
			'battery': true,
			'battery--empty': this.percentage <= 0,
			'battery--low': this.percentage > 0 && this.percentage <= 20,
			'battery--medium': this.percentage > 20 && this.percentage <= 50,
			'battery--high': this.percentage > 50 && this.percentage <= 80,
			'battery--full': this.percentage > 80
		}
	}

	fillClasses() {
		return {
			'fill': true,
			'fill--empty': this.percentage <= 0,
			'fill--low': this.percentage > 0 && this.percentage <= 20,
			'fill--medium': this.percentage > 20 && this.percentage <= 50,
			'fill--high': this.percentage > 50 && this.percentage <= 80,
			'fill--full': this.percentage > 80
		}
	}

	ngOnInit(): void {
	}

}
