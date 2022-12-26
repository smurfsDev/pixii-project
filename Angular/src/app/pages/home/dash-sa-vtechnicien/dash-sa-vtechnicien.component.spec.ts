import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashSaVTechnicienComponent } from './dash-sa-vtechnicien.component';

describe('DashSaVTechnicienComponent', () => {
  let component: DashSaVTechnicienComponent;
  let fixture: ComponentFixture<DashSaVTechnicienComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DashSaVTechnicienComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashSaVTechnicienComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
