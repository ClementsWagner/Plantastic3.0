import { TestBed } from '@angular/core/testing';

import { SensorRestService } from './sensor-rest.service';

describe('SensorRestService', () => {
  let service: SensorRestService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SensorRestService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
