import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import {AfterViewInit, ViewChild} from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import { Sort } from '@angular/material/sort';
import { ManageUsersService } from 'src/app/service/users/superAdmin/manage-users.service';

@Component({
  selector: 'app-mg-users',
  templateUrl: './mg-users.component.html',
  styleUrls: ['./mg-users.component.scss']
})
export class MgUsersComponent implements AfterViewInit, OnInit {
  // filterByRole = new FormControl('all' as ThemePalette);
  // filterByStatus = new FormControl('all' as ThemePalette);
  dataFilters: dataFilter[]=[];
  Roles : any = [{value: 'All',name: 'All'}];
  Status : any = [{value: 'All',name: 'All'},{value: 1,name: 'Active'}, {value: 0,name: 'Inactive'}];
  authUser: User | undefined;
  displayedColumns: string[] = ['name', 'role', 'email', 'status', 'actions'];
  ELEMENT_DATAFilled: any =[];

  filterDictionary= new Map<string,string>();
  dataSource = new MatTableDataSource<any>(this.ELEMENT_DATAFilled);
  FiltredData : any =[];
  @ViewChild(MatPaginator)
  paginator!: MatPaginator;
  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
  }
  constructor(private store:Store, private ManageUsersService : ManageUsersService) {
    this.fetchUsers();
  }

  ngOnInit(): void {
    this.authUser = this.store.selectSnapshot(state => state.AuthState.user);
    this.dataFilters.push({name: 'Role', options: this.Roles,defaultValue: 'All'});
    this.dataFilters.push({name: 'Status', options: this.Status,defaultValue: 'All'});
    this.fetchRoles();
    this.fetchUsers();
  }
  announceSortChange(sortState: Sort) {
    if (sortState.direction) {
      this.dataSource.data = this.dataSource.data.sort((a, b) => {
        console.log("aaaa",a);
        const isAsc = sortState.direction === 'asc';
        switch (sortState.active) {
          case 'role': return compare(a[0].role.name, b[0].role.name, isAsc);
          case 'status': return compareStatus(a[0].status, b[0].status, isAsc);
          default: return 0;
        }
      });
    }
  }
  applyFilter(event: any,dataFilter:dataFilter) {
    var LastFilter : any[] = [];
    this.ELEMENT_DATAFilled = this.FiltredData;
    this.dataFilters.forEach(dataFilter => {
         this.filterDictionary.set(dataFilter.name,dataFilter.defaultValue);
    });
    this.filterDictionary.set(dataFilter.name,event.value);
    this.dataSource.filter = JSON.stringify(Array.from(this.filterDictionary.entries()));
    this.ELEMENT_DATAFilled.forEach((element: any) => {
      if(this.filterDictionary.get('Role') == 'All' || this.filterDictionary.get('Role') == element[0].role.name){
        if(this.filterDictionary.get('Status') == 'All' || this.filterDictionary.get('Status') == element[0].status){
          LastFilter.push(element);
        }
      }
    });
    this.dataSource = new MatTableDataSource<any>(LastFilter);
  }
  fetchRoles() {
    this.ManageUsersService.fetchRoles().subscribe((data:any) => {
      data.roles.forEach((role: any) => {
        this.Roles.push({value: role.name,name: role.name});
      });
    }
    );
  }
  fetchUsers() {
    this.ManageUsersService.fetchUsers().subscribe((data:any) => {
      this.ELEMENT_DATAFilled = data.users;
      this.dataSource = new MatTableDataSource<any>(this.ELEMENT_DATAFilled);
      this.FiltredData = this.dataSource.data;
    });
  }
  acceptUser(idUser : number,idRole : number) {
    this.ManageUsersService.acceptUser(idUser,idRole).subscribe((data) => {
      console.log(data);
      console.log("accept");
      this.fetchUsers();
    });
  }
  rejectUser(idUser : number,idRole : number) {
    this.ManageUsersService.rejectUser(idUser,idRole).subscribe((data) => {
      console.log(data);
      console.log("reject");
      this.fetchUsers();
    });
  }
}
export interface dataFilter {
  name:string;
  options:any[];
  defaultValue:string;
}
function compare(name: string, name1: string, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}
function compareStatus(name: number, name1: number, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}

