import { Component, OnInit } from '@angular/core';
import { ClaimsService } from 'src/app/service/claims/claims.service';
import { CommentService } from 'src/app/service/claims/comment.service';

@Component({
	selector: 'app-user',
	templateUrl: './user.component.html',
	styleUrls: ['./user.component.scss']
})
export class UserComponent implements OnInit {

	constructor(private claimsService: ClaimsService,private commentService:CommentService) { }

	claims: any = [];
	opened = false;
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
		_status: [
			{
				"old_status": "Done",
				"new_status": "In Progress",
				"date": "2022-11-16T19:10:56.107Z",
				"author": {
						name:"",
						image:"",
					}
			},
			{
				"old_status": "In Progress",
				"new_status": "Stuck",
				"date": "2022-11-16T19:10:56.107Z",
				"author": {
						name:"",
						image:"",
					}
			},
			{
				"old_status": "Stuck",
				"new_status": "In Progress",
				"date": "2022-11-16T19:10:56.107Z",
				"author": {
						name:"",
						image:"",
					}
			},
		],
		_technician: [
				{
					"old_technician": "John Doe",
					"new_technician": "John Doe",
					"date": "2022-11-16T19:10:56.107Z",
					"author": {
						name:"",
						image:"",
					}
				}	
		],
		technician: null,
	};
	openDetails(id: any) {
		this.opened = false;
		setTimeout(() => {
			this.opened = true;
		}, 100);
		this.fetchClaimDetails(id)
	}
	fetchClaimDetails(id: any) {
		this.claimsService.getClaim(id).subscribe((data: any) => {
			this.claim = data;
			this.claim.status = data.status.name;
			let _status: {
				old_status: string,
				new_status: string,
				author: {
					name: string,
					image:string,
				},
				date: string
			}[] = [];
			let _technician : {
				old_technician: string,
				new_technician: string,
				author: {
					name: string,
					image:string,
				},
				date: string
			}[] = [];


			data._status.forEach((element: any) => {
				_status.push({
					old_status: element.old_status.name,
					new_status: element.new_status.name,
					author: element.author,
					date: element.date
				});
			}
			);
			data._technician.forEach((element: any) => {
				_technician.push({
					old_technician: element.old_technician.name,
					new_technician: element.new_technician.name,
					author: element.author,
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

	commented(event: any) {
		const comment = {
			claim: this.claim._id,
			message: event
		};

		this.commentService.comment(comment).subscribe(data => {
			this.fetchClaimDetails(this.claim._id);
		}
		)
	}


	ngOnInit(): void {
		this.claimsService.getClaimsMine().subscribe((data: any) => {
			this.claims = data;
		});
	}

}
