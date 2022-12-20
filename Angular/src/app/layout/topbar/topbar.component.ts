import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { LogoutAction } from 'src/app/store/auth/actions';
import { Router } from '@angular/router';

@Component({
  selector: 'app-topbar',
  templateUrl: './topbar.component.html',
  styleUrls: ['./topbar.component.scss']
})
export class TopbarComponent implements OnInit {
  vehicle = false;
  location = false;
  controlPanel = false;
  @Output() value = new EventEmitter<any>();

  constructor(private store: Store,private router:Router) { }

  authUser: User | undefined;
  ngOnInit(): void {
  }

  logout() {
	this.store.dispatch(new LogoutAction());
	this.router.navigate(['/auth']);
  }
  vehicule() {
    this.vehicle = true;
    this.location = false;
    this.controlPanel = false;
    this.values();
  }
  Location(){
    this.vehicle = false;
    this.location = true;
    this.controlPanel = false;
    this.values();
  }
  ControlPanel(){
    this.vehicle = false;
    this.location = false;
    this.controlPanel = true;
    this.values();
    // console.log(this.vehicle,this.location,this.controlPanel);
  }
  values(){
    this.value.emit({
      vehicle:this.vehicle,
      location:this.location,
      controlPanel:this.controlPanel
    })
  }

}
