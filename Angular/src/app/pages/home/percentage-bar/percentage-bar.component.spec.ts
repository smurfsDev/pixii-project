import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BatteryPercentageComponent } from './percentage-bar.component';

describe('BatteryPercentageComponent', () => {
  let component: BatteryPercentageComponent;
  let fixture: ComponentFixture<BatteryPercentageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [BatteryPercentageComponent]
    })
      .compileComponents();

    fixture = TestBed.createComponent(BatteryPercentageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
