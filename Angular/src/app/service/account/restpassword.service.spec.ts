import { TestBed } from '@angular/core/testing';

import { RestpasswordService } from './restpassword.service';

describe('RestpasswordService', () => {
  let service: RestpasswordService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RestpasswordService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
