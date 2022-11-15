import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit, VERSION } from '@angular/core';
import { Board } from 'src/app/models/board.model';
import { Claim } from 'src/app/models/claim.model';
import { Column } from 'src/app/models/column.model';
import { ClaimsService } from 'src/app/service/claims/claims.service';
import { StatusService } from 'src/app/service/claims/status.service';
import { DetailsComponent } from './details/details.component';

@Component({
	selector: 'app-claims',
	templateUrl: './claims.component.html',
	styleUrls: ['./claims.component.scss']
})
export class ClaimsComponent implements OnInit {

	claimsData: any;
	claim = {
		subject: "Claim subject",
		status: "Done",
		message: `Lorem ipsum dolor sit amet consectetur adipisicing elit. In quae ex, tempore consequuntur labore
					autem deleniti laboriosam sint ad voluptatem accusantium ducimus sed minus earum officia illo ipsam
					quis. Deleniti.`,
		created: "2022-01-01",
		comments: [
			{
				name: "John Doe",
				avatar: "https://randomuser.me/api/portraits/men/1.jpg",
				message: `Lorem ipsum dolor sit amet consectetur adipisicing elit. In quae ex, tempore consequuntur labore`,
				created: "2022-01-01"
			},
			{
				name: "John Doe",
				avatar: "https://randomuser.me/api/portraits/men/2.jpg",
				message: `Lorem ipsum dolor sit amet consectetur adipisicing elit. In quae ex, tempore consequuntur labore`,
				created: "2022-01-01"
			},
		]
	};
	opened = false;
	openDetails(id: any) {
		console.log(id);
		this.opened = false;
		setTimeout(() => {
			this.opened = true;
		}, 100);
		this.claimsService.getClaim(id).subscribe((data: any) => {
			this.claim = data;
			this.claim.status = data.status.name;
		});
	}
	constructor(private claimsService: ClaimsService, private statusService: StatusService) { }
	name = 'Angular Material ' + VERSION.major + ' Kanban board';
	public board: Board = new Board("", []);
	current = '/home';
	ids: string[] = [];

	toggleActive(event: any) {
		console.log(event);
	}

	ngOnInit(): void {
		this.fetchClaims();
	}

	async fetchClaims(): Promise<void> {
		this.board = new Board("", []);
		await this.statusService.getStatus().forEach((status: any) => {
			status.forEach((element: any) => {
				this.ids.push(element._id);
				this.board.columns.push(new Column(element.name, element._id, []));
			});
		});

		this.claimsService.getClaims().forEach((claim: any) => {
			claim.forEach((element: any) => {
				console.log(element);
				this.board.columns.forEach((column: any) => {
					if (column.id === element.status._id) {
						column.claims.push(new Claim(element._id, element.subject, element.description, element.created, element.status._id));
					}
				});
			});
		});
	}

	async fetchOnlyClaims(): Promise<void> {
		this.board.columns.forEach((column: any) => {
			column.claims = [];
		});
		this.claimsService.getClaims().forEach((claim: any) => {
			claim.docs.forEach((element: any) => {
				this.board.columns.forEach((column: any) => {
					if (column.id === element.status._id) {
						column.claims.push(new Claim(element._id, element.subject, element.description, element.created, element.status._id));
					}
				});
			});
		});
	};


	public dropGrid(event: CdkDragDrop<Claim[]>): void {
		moveItemInArray(this.board.columns, event.previousIndex, event.currentIndex);
	}

	public drop(event: CdkDragDrop<Claim[]>): void {
		if (event.previousContainer === event.container) {
			moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
		} else {
			transferArrayItem(event.previousContainer.data,
				event.container.data,
				event.previousIndex,
				event.currentIndex);
			var claim = event.container.data[event.currentIndex];
			claim.status = event.container.id;
			this.claimsService.putClaims(claim).subscribe(data => {
				console.log(data);
				// this.fetchOnlyClaims();
			});
		}
	}

}
