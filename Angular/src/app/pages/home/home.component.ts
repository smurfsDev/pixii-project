import { Component, OnInit } from '@angular/core';

import { Store } from '@ngxs/store';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']

})
export class HomeComponent implements OnInit {
  isSuperAdmin: boolean = false;
  isAdmin: boolean = false;
  isSavManager: boolean = false;
  isSavTechnician: boolean = false;
  isScooterOwner: boolean = false;
  isAuth: boolean = false;
  constructor(private store: Store) {
    // this.store.selectSnapshot(state => state.AuthState)
    this.store.select(state => state.AuthState).subscribe(user => {
      if (user) {
        this.isSuperAdmin = user.isSuperAdmin;
        this.isAdmin = user.isAdmin;
        this.isSavManager = user.isSAVManager;
        this.isSavTechnician = user.isSAVTechnician;
        this.isScooterOwner = user['isScooterOwner'].isScooterOwner;
        this.isAuth = user.isAuthenticated;
      }
    });
  }
  ngOnInit(): void {
  }

}
