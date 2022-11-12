import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
	selector: 'app-navbar',
	templateUrl: './navbar.component.html',
	styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {

	isExpanded = false;

	current = '/dashboard';
	
	
	constructor(private router: Router) { }
	
	toggleActive(event: string) {
		this.router.navigate([event]);
		this.current = event;
	}

	ngOnInit(): void {
		this.current = this.router.url;
	}

}
