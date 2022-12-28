import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../../../../service/account/profile.service';

@Component({
  selector: 'app-nav-profile',
  templateUrl: './nav-profile.component.html',
  styleUrls: ['./nav-profile.component.scss'],
})
export class NavProfileComponent implements OnInit {
  profile: any;
  name: any;

  constructor(private ProfileService: ProfileService) {}

  ngOnInit(): void {
    this.getProfilePicture();
    this.getProfile();
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
