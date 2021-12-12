import { Component, OnInit } from '@angular/core';
import {HomeStation} from "../../models/home-station";
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: 'app-home-station',
  templateUrl: './home-station.component.html',
  styleUrls: ['./home-station.component.css']
})
export class HomeStationComponent {

  homeStations: HomeStation[] = [{id: 0, name: "Erdgeschoss", serialnumber: "1e-43-5a-f3"}, {id: 0,name: "Obergeschoss", serialnumber: "2c-14-3f-d5"}];

  constructor() {

  }

}
