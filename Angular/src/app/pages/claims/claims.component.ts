import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit, VERSION } from '@angular/core';
import { Board } from 'src/app/models/board.model';
import { Claim } from 'src/app/models/claim.model';
import { Column } from 'src/app/models/column.model';
import { ClaimsService } from 'src/app/service/claims.service';

@Component({
	selector: 'app-claims',
	templateUrl: './claims.component.html',
	styleUrls: ['./claims.component.scss']
})
export class ClaimsComponent implements OnInit {

	newData: any;

	constructor(private _apiService: ClaimsService) { }
	name = 'Angular Material ' + VERSION.major + ' Kanban board';
	public board: Board = new Board("", []);
	current = '/home';

	toggleActive(event: any) {
		console.log(event);
	}

	ngOnInit(): void {
		this.fetchClaims();
	}

	fetchClaims(): void {
		this._apiService.getClaims().subscribe(data => {
			console.log(data);
			this.newData = data;
			const claimList = this.newData.docs.map((claim: any) => {
				return new Claim(claim._id, claim.message, claim.subject, claim.created, claim.status);
			});
			const todoClaims = claimList.filter((claim: Claim) => claim.status == 1);
			const inProgressClaims = claimList.filter((claim: Claim) => claim.status == 2);
			const stuckClaims = claimList.filter((claim: Claim) => claim.status == 3);
			const doneClaims = claimList.filter((claim: Claim) => claim.status == 4);
			this.board = new Board('Test Board', [
				new Column('Todo', '1',
					todoClaims
				),
				new Column('InProgress', '2',
					inProgressClaims
				),
				new Column('Stuck', '3',
					stuckClaims
				),
				new Column('Done', '4',
					doneClaims
				),
			]);
		});
	}


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
			claim.status = parseInt(event.container.id);
			this._apiService.putClaims(claim).subscribe(data => {
				console.log(data);
				this.fetchClaims();
			});
		}
	}

}
