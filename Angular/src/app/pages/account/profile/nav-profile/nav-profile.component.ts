import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../../../../service/account/profile.service';
import { Router } from '@angular/router';
import { User } from '../../../../models/user';
import { LogoutAction } from 'src/app/store/auth/actions';
import { Store } from '@ngxs/store';

@Component({
  selector: 'app-nav-profile',
  templateUrl: './nav-profile.component.html',
  styleUrls: ['./nav-profile.component.scss'],
})
export class NavProfileComponent implements OnInit {
  profile: any;
  name: any;

  constructor(
    private ProfileService: ProfileService,
    private Store: Store,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.getProfilePicture();
    this.getProfile();
  }
  logout() {
    this.Store.dispatch(new LogoutAction());
    this.router.navigate(['/auth']);
  }
  getProfilePicture() {
    this.ProfileService.getProfilePicture().subscribe((data: any) => {
      this.profile = data;
    });
  }
  getProfile() {
    this.ProfileService.getProfile().subscribe((data: any) => {
      this.name = data;
    });
  }
}
