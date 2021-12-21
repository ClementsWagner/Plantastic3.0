import { TestBed } from '@angular/core/testing';

import { HomestationRestService } from './homestation-rest.service';

describe('HomestationRestService', () => {
  let service: HomestationRestService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HomestationRestService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
