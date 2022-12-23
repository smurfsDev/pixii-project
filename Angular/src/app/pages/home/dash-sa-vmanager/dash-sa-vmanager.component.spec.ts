import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashSaVManagerComponent } from './dash-sa-vmanager.component';

describe('DashSaVManagerComponent', () => {
  let component: DashSaVManagerComponent;
  let fixture: ComponentFixture<DashSaVManagerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DashSaVManagerComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashSaVManagerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
