import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { LogoutAction } from 'src/app/store/auth/actions';
import { Router } from '@angular/router';
import { ProfileService } from '../../service/account/profile.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-topbar',
  templateUrl: './topbar.component.html',
  styleUrls: ['./topbar.component.scss'],
})
export class TopbarComponent implements OnInit {
  vehicle = false;
  location = false;
  controlPanel = false;
  isScooterOwner = false;
  profile: any;
  name: any;
  env = environment.apiUrl;

  @Output() value = new EventEmitter<any>();
  BtnVehicule = {
    color: '#ffffffa4',
    fontSize: '18px',
  };
  BtnLocation = {
    color: '#ffffffa4',
    fontSize: '18px',
  };
  BtnControlPanel = {
    color: '#ffffffa4',
    fontSize: '18px',
  };

  constructor(
    private ProfileService: ProfileService,
    private store: Store,
    private router: Router
  ) {}

  authUser: User | undefined;
  ngOnInit(): void {
    this.store
      .select((state) => state.AuthState)
      .subscribe((user) => {
        if (user) {
          this.authUser = user.user;
          this.isScooterOwner = user['isScooterOwner'].isScooterOwner;
        }
      });
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

  logout() {
    this.store.dispatch(new LogoutAction());
    this.router.navigate(['/auth']);
  }
  vehicule() {
    this.initBtn();
    this.vehicle = true;
    this.location = false;
    this.controlPanel = false;
    this.BtnVehicule = {
      color: '#fff',
      fontSize: '21px',
    };
    this.values();
  }
  Location() {
    this.initBtn();

    this.vehicle = false;
    this.location = true;
    this.controlPanel = false;
    this.BtnLocation = {
      color: '#fff',
      fontSize: '21px',
    };
    this.values();
  }
  ControlPanel() {
    this.initBtn();

    this.vehicle = false;
    this.location = false;
    this.controlPanel = true;
    this.BtnControlPanel = {
      color: '#fff',
      fontSize: '21px',
    };
    this.values();
    // console.log(this.vehicle,this.location,this.controlPanel);
  }
  initBtn() {
    this.BtnVehicule = {
      color: '#ffffffa4',
      fontSize: '18px',
    };
    this.BtnLocation = {
      color: '#ffffffa4',
      fontSize: '18px',
    };
    this.BtnControlPanel = {
      color: '#ffffffa4',
      fontSize: '18px',
    };
  }
  values() {
    this.value.emit({
      vehicle: this.vehicle,
      location: this.location,
      controlPanel: this.controlPanel,
    });
  }
}
