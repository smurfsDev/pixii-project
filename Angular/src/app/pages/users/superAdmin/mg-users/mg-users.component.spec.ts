import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MgUsersComponent } from './mg-users.component';

describe('MgUsersComponent', () => {
  let component: MgUsersComponent;
  let fixture: ComponentFixture<MgUsersComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MgUsersComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MgUsersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
