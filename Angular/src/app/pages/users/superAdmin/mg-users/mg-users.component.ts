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
  Roles : any = [{value: 'All',name: 'All'}];
  Status : any = [{value: 'All',name: 'All'},{value: 1,name: 'Active'}, {value: 0,name: 'Inactive'}];
  authUser: User | undefined;
  displayedColumns: string[] = ['name', 'role', 'email', 'status', 'actions'];
  ELEMENT_DATAFilled: any =[];
  searchText = '';
  filterRoles: string = 'All';
  filterStatus: string = 'All';
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
  applyFilterByRole(event: any) {
    this.filterRoles = event.value;
    this.filterSequence();

  }
  applyFilterByStatus(event: any) {
    this.filterStatus = event.value;
    this.filterSequence();

  }
  applySearch(event: Event) {
    this.searchText = (event.target as HTMLInputElement).value;
    this.filterSequence();
  }
  filterSequence() {
    let arr = this.ELEMENT_DATAFilled.filter((item:any) => {
      console.log("item",item);

      if(this.filterRoles == 'All' && this.filterStatus == 'All'){
        return item[0].user.name.toLowerCase().includes(this.searchText.toLowerCase());
      }else if (this.filterRoles !='All' && this.filterStatus == 'All'){
        return item[0].role.name.toLowerCase()==(this.filterRoles.toLowerCase()) && item[0].user.name.toLowerCase().includes(this.searchText.toLowerCase());
      } else if (this.filterRoles == 'All' && this.filterStatus != 'All'){
        return item[0].status==(this.filterStatus) && item[0].user.name.toLowerCase().includes(this.searchText.toLowerCase());
      } else if (this.filterRoles != 'All' && this.filterStatus != 'All'){
        return item[0].role.name.toLowerCase()==(this.filterRoles.toLowerCase()) && item[0].status==(this.filterStatus) && item[0].user.name.toLowerCase().includes(this.searchText.toLowerCase());
      }
      else{
        return true;
      }
    });
    this.dataSource = new MatTableDataSource<any>(arr);
    this.dataSource.paginator = this.paginator;
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
// export interface dataFilter {
//   name:string;
//   options:any[];
//   defaultValue:string;
// }
function compare(name: string, name1: string, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}
function compareStatus(name: number, name1: number, isAsc: boolean): number {
  return (name < name1 ? -1 : 1) * (isAsc ? 1 : -1);
}

