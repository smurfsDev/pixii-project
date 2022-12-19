import { TestBed } from '@angular/core/testing';

import { BikeDataService } from './bike-data.service';

describe('BikeDataService', () => {
  let service: BikeDataService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(BikeDataService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
