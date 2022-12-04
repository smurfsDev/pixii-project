import { TestBed } from '@angular/core/testing';

import { ManageUsersService } from './manage-users.service';

describe('ManegeUsersService', () => {
  let service: ManageUsersService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ManageUsersService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
