import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashSuperAdminComponent } from './dash-super-admin.component';

describe('DashSuperAdminComponent', () => {
  let component: DashSuperAdminComponent;
  let fixture: ComponentFixture<DashSuperAdminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DashSuperAdminComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashSuperAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
