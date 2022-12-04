import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import {AfterViewInit, ViewChild} from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import { Sort } from '@angular/material/sort';
import {FormControl} from '@angular/forms';
import { ThemePalette } from '@angular/material/core';
import { MatSelectChange } from '@angular/material/select';

@Component({
  selector: 'app-mg-users',
  templateUrl: './mg-users.component.html',
  styleUrls: ['./mg-users.component.scss']
})
export class MgUsersComponent implements AfterViewInit  {
  filterByRole = new FormControl('all' as ThemePalette);
  filterByStatus = new FormControl('all' as ThemePalette);
  dataFilters: dataFilter[]=[];
  Roles : any = [{value: 'All',name: 'All'}, {value: 'Admin',name: 'Admin'}, {value: 'User',name: 'User'}, {value: 'Super Admin',name: 'Super Admin'}, {value: 'Scooter Owner',name: 'Scooter Owner'}];
  Status : any = [{value: 'All',name: 'All'},{value: 1,name: 'Active'}, {value: 0,name: 'Inactive'}];
  authUser: User | undefined;
  displayedColumns: string[] = ['name', 'role', 'email', 'status', 'actions'];
  ELEMENT_DATAFilled: any = ELEMENT_DATA;
  filterDictionary= new Map<string,string>();
  dataSource = new MatTableDataSource<PeriodicElement>(this.ELEMENT_DATAFilled);
  @ViewChild(MatPaginator)
  paginator!: MatPaginator;
  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
  }
  constructor(private store:Store) { }

  ngOnInit(): void {
    this.authUser = this.store.selectSnapshot(state => state.AuthState.user);
    this.dataFilters.push({name: 'Role', options: this.Roles,defaultValue: 'All'});
    this.dataFilters.push({name: 'Status', options: this.Status,defaultValue: 'All'});
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
  applyFilter(event: any,dataFilter:dataFilter) {
    var LastFilter : any[] = [];
    this.ELEMENT_DATAFilled = ELEMENT_DATA;
    this.dataFilters.forEach(dataFilter => {
         this.filterDictionary.set(dataFilter.name,dataFilter.defaultValue);
    });
    this.filterDictionary.set(dataFilter.name,event.value);
    this.dataSource.filter = JSON.stringify(Array.from(this.filterDictionary.entries()));
    this.ELEMENT_DATAFilled.forEach((element: any) => {
      if(this.filterDictionary.get('Role') == 'All' || this.filterDictionary.get('Role') == element.role){
        if(this.filterDictionary.get('Status') == 'All' || this.filterDictionary.get('Status') == element.Status){
          LastFilter.push(element);
        }
      }
    });
    this.dataSource = new MatTableDataSource<PeriodicElement>(LastFilter);
  }
}
export interface dataFilter {
  name:string;
  options:any[];
  defaultValue:string;
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
  {name: 'Foulen il fouleni', role: 'User', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Scooter Owner', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'User', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Scooter Owner', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Super Admin', email: 'foulen@gmail.com', Status: 0, actions: 'Edit'},
  {name: 'Foulen il fouleni', role: 'Admin', email: 'foulen@gmail.com', Status: 1, actions: 'Edit'},
];
function compare(name: string, name1: string, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}
function compareStatus(name: number, name1: number, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}

