import { Component, OnInit } from '@angular/core';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { UsersService } from 'src/app/service/account/users.service';
import { ClaimsService } from 'src/app/service/claims/claims.service';

@Component({
  selector: 'app-chef',
  templateUrl: './chef.component.html',
  styleUrls: ['./chef.component.scss']
})
export class ChefComponent implements OnInit {

  constructor(private store:Store,private claimsService: ClaimsService,private usersService:UsersService) { }
  
  authUser: User | undefined;
  claims: any[] = [];
  users: any[] = [];
  ngOnInit(): void {
	  this.authUser = this.store.selectSnapshot(state => state.AuthState.user);
	  this.claims=[];
	  this.users=[];
	  this.claimsService.getClaims().subscribe((data: any) => {
		  this.claims = data;
	  });

	  this.usersService.getUsers().subscribe((data: any) => {
		  this.users = data;
	  });
  }

  affectClaim(claim:any,technician:any) {
	  this.claimsService.affectClaim(claim,technician).subscribe((data: any) => {
		  this.ngOnInit();
	  });
  }


}
