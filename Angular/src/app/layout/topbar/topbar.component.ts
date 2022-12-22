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
  BtnVehicule = {
    color: '#ffffffa4',
    fontSize: '18px',
  }
  BtnLocation = {
    color: '#ffffffa4',
    fontSize: '18px',
  }
  BtnControlPanel = {
    color: '#ffffffa4',
    fontSize: '18px',
  }

  constructor(private store: Store,private router:Router) { }

  authUser: User | undefined;
  ngOnInit(): void {
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
    }
    this.values();
  }
  Location(){
        this.initBtn();

    this.vehicle = false;
    this.location = true;
    this.controlPanel = false;
    this.BtnLocation = {
      color: '#fff',
      fontSize: '21px',
    }
    this.values();
  }
  ControlPanel(){
        this.initBtn();

    this.vehicle = false;
    this.location = false;
    this.controlPanel = true;
    this.BtnControlPanel = {
      color: '#fff',
      fontSize: '21px',
    }
    this.values();
    // console.log(this.vehicle,this.location,this.controlPanel);
  }
  initBtn(){
    this.BtnVehicule = {
      color: '#ffffffa4',
      fontSize: '18px',
    }
    this.BtnLocation = {
      color: '#ffffffa4',
      fontSize: '18px',
    }
    this.BtnControlPanel = {
      color: '#ffffffa4',
      fontSize: '18px',
    }
  }
  values(){
    this.value.emit({
      vehicle:this.vehicle,
      location:this.location,
      controlPanel:this.controlPanel
    })
  }

}
