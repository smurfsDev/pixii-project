import { Component, OnInit, Input, OnChanges } from '@angular/core';
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
export class NavProfileComponent implements OnInit, OnChanges {
  profile: any;
  name: any;
  authState: any | undefined;
  @Input() image: string | null = null;

  constructor(
    private ProfileService: ProfileService,
    private Store: Store,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.authState = this.Store.selectSnapshot((state) => state.AuthState);
    this.name = this.authState.user.name;

    console.log(this.image);
  }

  ngOnChanges(): void {
    console.log(this.image);
  }

  logout() {
    this.Store.dispatch(new LogoutAction());
    this.router.navigate(['/auth']);
  }
}
