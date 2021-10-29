import { Component, OnInit } from '@angular/core';
import {homeStation} from "../../models/home-station";
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: 'app-home-station',
  templateUrl: './home-station.component.html',
  styleUrls: ['./home-station.component.css']
})
export class HomeStationComponent {

  homeStations: homeStation[] = [new homeStation("Erdgeschoss", "1e-43-5a-f3"), new homeStation("Obergeschoss", "2c-14-3f-b5")];

  constructor() {

    this.homeStations[0].active=true;
  }
}
