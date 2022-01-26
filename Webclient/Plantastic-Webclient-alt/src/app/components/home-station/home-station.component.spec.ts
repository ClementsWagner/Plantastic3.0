import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HomeStationComponent } from './home-station.component';

describe('HomeStationComponent', () => {
  let component: HomeStationComponent;
  let fixture: ComponentFixture<HomeStationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ HomeStationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HomeStationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
