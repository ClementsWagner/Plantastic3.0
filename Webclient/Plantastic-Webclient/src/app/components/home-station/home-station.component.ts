import { Component, OnInit } from '@angular/core';
import {HomeStation} from "../../models/home-station";
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: 'app-home-station',
  templateUrl: './home-station.component.html',
  styleUrls: ['./home-station.component.css']
})
export class HomeStationComponent {

  homeStations: HomeStation[] = [{name: "Erdgeschoss", serialnumber: "1e-43-5a-f3", active: true}, {name: "Obergeschoss", serialnumber: "2c-14-3f-d5", active: false}];

  constructor() {

    this.homeStations[0].active=true;
  }

}
