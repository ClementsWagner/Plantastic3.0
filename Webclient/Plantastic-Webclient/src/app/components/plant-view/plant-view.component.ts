import { Component, OnInit } from '@angular/core';
import {HomeStation} from "../../models/home-station";
import {ActivatedRoute} from "@angular/router";
import {Sensor} from "../../models/sensor";
import {SidenavService} from "../../services/sidenav.service";
import { HostListener } from '@angular/core';
import { SensorRestService } from 'src/app/services/Rest-services/sensor-rest.service';

@Component({
  selector: 'app-plant-view',
  templateUrl: './plant-view.component.html',
  styleUrls: ['./plant-view.component.css']
})
export class PlantViewComponent implements OnInit {

  //dummy data--
  homeStations: HomeStation[] = [{id: 0,userId:1,name: "Erdgeschoss", serialnumber: "1e-43-5a-f3"}, {id: 0, userId: 1,name: "Obergeschoss", serialnumber: "2c-14-3f-d5"}];
  sensors: Sensor[] = []
  plantTypes: string[] = ["Orchidee", "Hauspflanze", "Beere", "Gemüse"]
  //--

  homeStation: HomeStation | undefined;

  constructor(private route: ActivatedRoute, public sidenavService: SidenavService, public sensorRest: SensorRestService) {

  }

  ngOnInit(): void {
    this.sidenavService.showNotify()
    const routeParams = this.route.snapshot.paramMap;
    const serialNumberFromRoute = String(routeParams.get('homeStationId'));

    this.homeStation = this.findHomeStation(serialNumberFromRoute);

    if (this.homeStation)
      this.sensors = this.getSensors(this.homeStation);
  }

  @HostListener('window:popstate', ['$event'])
  onPopState(){
    this.sidenavService.hideNotify()
  }

  getSensors(homeStation: HomeStation){
    return [{id: 0, homeStationId: 0, name: "Glücksfeder", status: 0, plantType: "Hauspflanze"}]
  }

  findHomeStation(serialNumber: string){
    return this.homeStations.find(h => h.serialnumber==serialNumber)
  }

}


