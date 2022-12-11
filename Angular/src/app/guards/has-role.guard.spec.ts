import { TestBed } from '@angular/core/testing';

import { HasRoleGuard } from './has-role.guard';

describe('HasRoleGuard', () => {
  let guard: HasRoleGuard;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    guard = TestBed.inject(HasRoleGuard);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });
});
