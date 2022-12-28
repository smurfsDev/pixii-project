import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashScooterOwnerComponent } from './dash-scooter-owner.component';

describe('DashScooterOwnerComponent', () => {
  let component: DashScooterOwnerComponent;
  let fixture: ComponentFixture<DashScooterOwnerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DashScooterOwnerComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashScooterOwnerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
