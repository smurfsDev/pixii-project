import { Component, OnInit, Input, AfterViewInit } from '@angular/core';
// import { batteryArrayElement } from '../models/battery-array-element.model';
import { batteryArrayElement } from 'src/app/models/battery-array-element.model';

@Component({
  selector: 'battery-percentage',
  templateUrl: './percentage-bar.component.html',
  styleUrls: ['./percentage-bar.component.css']
})
export class BatteryPercentageComponent {
  @Input()
  public color!: string;
  @Input()
  public percentage!: number;


  arrayColor: batteryArrayElement[] = [];
  totalPin = 5;
  pinColor = '#efefed';

  constructor() { }

  ngOnInit() {
    this.renderArrayColor();
    console.log(this.arrayColor);
  }

  renderArrayColor() {
    const part = 100 / this.totalPin;
    let currentLevel = 0 + part;
    for (let i = 0; i < this.totalPin; i++) {
      if (this.percentage >= currentLevel) {
        this.arrayColor.push({ full: true, color: this.color, width: '7px' });
        // this.arrayColor.push(this.arrayElement);
        currentLevel += part;
      } else {
        const newWidth = ((this.percentage - currentLevel + part) * 7) / 20;
        this.arrayColor.push({ full: false, color: this.pinColor, width: newWidth + 'px' });
        for (let j = i + 1; j < this.totalPin; j++) {
          this.arrayColor.push({ full: true, color: this.pinColor, width: '7px' });
        }
        break;
      }
    }
    console.log(this.arrayColor)
  }
}
