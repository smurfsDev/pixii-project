import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import {AfterViewInit, ViewChild} from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import { Sort } from '@angular/material/sort';
@Component({
  selector: 'app-mg-users',
  templateUrl: './mg-users.component.html',
  styleUrls: ['./mg-users.component.scss']
})
export class MgUsersComponent implements AfterViewInit  {
  authUser: User | undefined;
  displayedColumns: string[] = ['name', 'role', 'email', 'status', 'actions'];
  dataSource = new MatTableDataSource<PeriodicElement>(ELEMENT_DATA);
  @ViewChild(MatPaginator)
  paginator!: MatPaginator;
  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
  }


  constructor(private store:Store) { }

  ngOnInit(): void {
    this.authUser = this.store.selectSnapshot(state => state.AuthState.user);

  }
  announceSortChange(sortState: Sort) {
    if (sortState.direction) {
      this.dataSource.data = this.dataSource.data.sort((a, b) => {
        const isAsc = sortState.direction === 'asc';
        switch (sortState.active) {
          case 'role': return compare(a.role, b.role, isAsc);
          case 'status': return compareStatus(a.Status, b.Status, isAsc);
          default: return 0;
        }
      });
    }
  }
}
export interface PeriodicElement {
  name: string;
  role: string;
  email: string;
  Status: number;
  actions: string;
}

const ELEMENT_DATA: PeriodicElement[] = [
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
];
function compare(name: string, name1: string, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}
function compareStatus(name: number, name1: number, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}

