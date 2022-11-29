import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ChartBatteryUsageComponent } from './chart-battery-usage.component';

describe('ChartBatteryUsageComponent', () => {
  let component: ChartBatteryUsageComponent;
  let fixture: ComponentFixture<ChartBatteryUsageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ChartBatteryUsageComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ChartBatteryUsageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
