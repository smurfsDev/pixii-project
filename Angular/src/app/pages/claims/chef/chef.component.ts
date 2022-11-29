import { Component, OnInit } from '@angular/core';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { UsersService } from 'src/app/service/account/users.service';
import { ClaimsService } from 'src/app/service/claims/claims.service';
import { CommentService } from 'src/app/service/claims/comment.service';

@Component({
	selector: 'app-chef',
	templateUrl: './chef.component.html',
	styleUrls: ['./chef.component.scss']
})
export class ChefComponent implements OnInit {

	constructor(private store: Store, private claimsService: ClaimsService, private usersService: UsersService, private commentsService: CommentService) { }
	openCount = 0;
	resolvedCount = 0;
	openClaims: any[] = [];
	resolvedClaims: any[] = [];
	authUser: User | undefined;
	claims: any[] = [];
	users: any[] = [];
	claim = {
		_id: "",
		subject: "Claim subject",
		status: "Done",
		message: `Lorem ipsum dolor sit amet consectetur adipisicing elit. In quae ex, tempore consequuntur labore
					autem deleniti laboriosam sint ad voluptatem accusantium ducimus sed minus earum officia illo ipsam
					quis. Deleniti.`,
		created: "2022-01-01",
		comments: [
			{
				user:{
					name: "John Doe",
				},
				avatar: "https://randomuser.me/api/portraits/men/1.jpg",
				message: `Lorem ipsum dolor sit amet consectetur adipisicing elit. In quae ex, tempore consequuntur labore`,
				created: "2022-01-01"
			},
			{
				user:{
					name: "John Doe",
				},
				avatar: "https://randomuser.me/api/portraits/men/2.jpg",
				message: `Lorem ipsum dolor sit amet consectetur adipisicing elit. In quae ex, tempore consequuntur labore`,
				created: "2022-01-01"
			},
		],
		_status : [
			{
				"old_status": "Done",
				"new_status": "In Progress",
				"date": "2022-11-16T19:10:56.107Z"
			},
			{
				"old_status": "In Progress",
				"new_status": "Stuck",
				"date": "2022-11-16T19:10:56.107Z"
			},
			{
				"old_status": "Stuck",
				"new_status": "In Progress",
				"date": "2022-11-16T19:10:56.107Z"
			},
		],
		_technician: [
				{
					"old_technician": "John Doe",
					"new_technician": "John Doe",
					"date": "2022-11-16T19:10:56.107Z",
					"author": "John Doe"
				}	
		]
	};
	ngOnInit(): void {
		this.authUser = this.store.selectSnapshot(state => state.AuthState.user);
		this.claims = [];
		this.users = [];
		this.claimsService.getClaims().subscribe((data: any) => {
			this.claims = data;
			this.openCount = this.claims.filter((claim: any) => claim.status.name !== 'DONE').length;
			this.resolvedCount = this.claims.filter((claim: any) => claim.status.name === 'DONE').length;
			this.openClaims = this.claims.filter((claim: any) => claim.status.name !== 'DONE');
			this.resolvedClaims = this.claims.filter((claim: any) => claim.status.name === 'DONE');
		});

		this.usersService.getUsers().subscribe((data: any) => {
			this.users = data;
		});
	}

	affectClaim(claim: any, technician: any) {
		this.claimsService.affectClaim(claim, technician).subscribe((data: any) => {
			this.ngOnInit();
		});
	}

	fetchClaimDetails(id: any) {
		this.claimsService.getClaim(id).subscribe((data: any) => {
			this.claim = data;
			this.claim.status = data.status.name;
			let _status : {
				old_status: string,
				new_status: string,
				author: string,
				date: string
			}[] = [];
			let _technician : {
				old_technician: string,
				new_technician: string,
				author: string,
				date: string
			}[] = [];

			data._status.forEach((element: any) => {
				_status.push({
					old_status: element.old_status.name,
					new_status: element.new_status.name,
					author: element.author.name,
					date: element.date
				});
			}
			);
			data._technician.forEach((element: any) => {
				console.log(element.old_technician.name);
				_technician.push({
					old_technician: element.old_technician.name,
					new_technician: element.new_technician.name,
					author: element.author.name,
					date: element.date
				});
			}
			);
			_status.sort((a: any, b: any) => {
				return new Date(b.date).getTime() - new Date(a.date).getTime();
			});
			_technician.sort((a: any, b: any) => {
				return new Date(b.date).getTime() - new Date(a.date).getTime();
			});
			this.claim._status = _status;
			this.claim._technician = _technician;
			
		});
	}
	
	opened = false;
	openDetails(id: any) {
		console.log(id);
		this.opened = false;
		setTimeout(() => {
			this.opened = true;
		}, 100);
		this.fetchClaimDetails(id)
	}


	commented(event: any) {
		const comment = {
			claim: this.claim._id,
			message: event
		};

		this.commentsService.comment(comment).subscribe(data => {
			this.fetchClaimDetails(this.claim._id);
		}
		)
	}




}
