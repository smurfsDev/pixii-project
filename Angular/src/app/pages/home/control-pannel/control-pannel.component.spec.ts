import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ControlPannelComponent } from './control-pannel.component';

describe('ControlPannelComponent', () => {
  let component: ControlPannelComponent;
  let fixture: ComponentFixture<ControlPannelComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ControlPannelComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ControlPannelComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
