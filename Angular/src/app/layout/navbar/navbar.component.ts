import { Component, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { Router } from '@angular/router';

@Component({
	selector: 'app-navbar',
	templateUrl: './navbar.component.html',
	styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent {

	isExpanded = false;

	current = this.router.url;
	
	constructor(private router: Router) { 
		setInterval(() => {
			this.current = this.router.url;
		}, 125);
	}
	
	async toggleActive(event: string) {
		const navigated = await this.router.navigate([event])
		console.log(this.router.url);
		this.current = event;
		console.log(this.current);
	}


}
