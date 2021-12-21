import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddHomestationComponent } from './add-homestation.component';

describe('AddHomestationComponent', () => {
  let component: AddHomestationComponent;
  let fixture: ComponentFixture<AddHomestationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddHomestationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddHomestationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
