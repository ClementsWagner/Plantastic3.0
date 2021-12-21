import { Component, OnInit } from '@angular/core';
import { NewHomeStation } from 'src/app/models/new-home-station';

@Component({
  selector: 'app-add-homestation',
  templateUrl: './add-homestation.component.html',
  styleUrls: ['./add-homestation.component.css']
})
export class AddHomestationComponent implements OnInit {

  newHomestation: NewHomeStation = {name: "", serialnumber: ""}


  constructor() { }

  ngOnInit(): void {
  }

}
