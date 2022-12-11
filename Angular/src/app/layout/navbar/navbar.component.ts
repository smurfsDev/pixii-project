import { Component, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { Router } from '@angular/router';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';

@Component({
	selector: 'app-navbar',
	templateUrl: './navbar.component.html',
	styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent {

	// isExpanded = false;
	panelOpenState = false;
	showSubmenu = false;
	isShowing = false;
	showSubSubMenu: boolean = false;
	isExpanded = true;
  authUser: User | undefined;

	current = this.router.url;

	constructor(private router: Router,private store:Store) {
		setInterval(() => {
			this.current = this.router.url;
		}, 125);
	}
    ngOnInit(): void {
    this.authUser = this.store.selectSnapshot(state => state.AuthState.user);
  }

	async toggleActive(event: string) {
		const navigated = await this.router.navigate([event])
		console.log(this.router.url);
		this.current = event;
		console.log(this.current);
	}


}
