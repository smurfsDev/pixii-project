import { Component, OnInit } from '@angular/core';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { LogoutAction } from 'src/app/store/auth/actions';
import { Router } from '@angular/router';

@Component({
  selector: 'app-topbar',
  templateUrl: './topbar.component.html',
  styleUrls: ['./topbar.component.scss']
})
export class TopbarComponent implements OnInit {

  constructor(private store: Store,private router:Router) { }

  authUser: User | undefined;
  ngOnInit(): void {
  }

  logout() {
	this.store.dispatch(new LogoutAction());
	this.router.navigate(['/auth']);
  }

}
