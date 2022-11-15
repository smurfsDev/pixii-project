import { Component, Input, OnInit } from '@angular/core';

@Component({
	selector: 'app-details',
	templateUrl: './details.component.html',
	styleUrls: ['./details.component.scss']
})
export class DetailsComponent implements OnInit {
	constructor() { }
	@Input() opened!: boolean;
	@Input() claim: any;
	ngOnInit(): void {
	}

}
