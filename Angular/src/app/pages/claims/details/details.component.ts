import { AfterViewChecked, AfterViewInit, Component, ElementRef, EventEmitter, Input, OnChanges, OnInit, Output, QueryList, SimpleChanges, ViewChild, ViewChildren } from '@angular/core';

@Component({
	selector: 'app-details',
	templateUrl: './details.component.html',
	styleUrls: ['./details.component.scss']
})
export class DetailsComponent implements AfterViewInit,OnChanges {
	constructor() { }
	ngOnChanges(changes: SimpleChanges): void {
		this.selectedTab = 0;
	}
	comment = "";
	selectedTab = 0;
	@Input() opened!: boolean;
	@Input() claim: any;
	// @ts-ignore
	@ViewChildren('messages') messages: QueryList<any>;
	// @ts-ignore
	@ViewChild('scrollMe') content: ElementRef;

	ngAfterViewInit() {
		this.scrollToBottom();
		this.messages.changes.subscribe(this.scrollToBottom);
	}

	scrollToBottom = () => {
		this.content.nativeElement.scrollTop = this.content.nativeElement.scrollHeight;
	}

	selectTab(va:any){
		this.selectedTab = va.index;
	}

	@Output() commented: EventEmitter<string> = new EventEmitter()

	sendComment() {
		this.commented.emit(this.comment);
		this.comment = "";
	}

}
