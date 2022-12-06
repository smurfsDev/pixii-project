import { Component, OnInit } from '@angular/core';
import { ClaimsService } from 'src/app/service/claims/claims.service';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})
export class UserComponent implements OnInit {

  constructor(private claimsService: ClaimsService) { }

  claims : any;

  ngOnInit(): void {
	this.claimsService.getClaimsMine().subscribe((data:any) => {
		console.log(data);
		this.claims = data;
	});
  }

}
