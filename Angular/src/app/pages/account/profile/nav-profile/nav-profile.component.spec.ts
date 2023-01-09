import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavProfileComponent } from './nav-profile.component';

describe('NavProfileComponent', () => {
  let component: NavProfileComponent;
  let fixture: ComponentFixture<NavProfileComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavProfileComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(NavProfileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
