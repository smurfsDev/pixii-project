import { TestBed } from '@angular/core/testing';

import { CallbackService } from './callback.service';

describe('CallbackService', () => {
  let service: CallbackService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CallbackService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
