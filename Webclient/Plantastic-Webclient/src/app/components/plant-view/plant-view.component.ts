import { Component, OnInit } from '@angular/core';
import {homeStation} from "../../models/home-station";
import {ActivatedRoute} from "@angular/router";
import {sensor} from "../../models/sensor";
import {SidenavService} from "../../services/sidenav.service";
import { HostListener } from '@angular/core';

@Component({
  selector: 'app-plant-view',
  templateUrl: './plant-view.component.html',
  styleUrls: ['./plant-view.component.css']
})
export class PlantViewComponent implements OnInit {

  //dummy data--
  homeStations: homeStation[] = [new homeStation("Erdgeschoss", "1e-43-5a-f3"), new homeStation("Obergeschoss", "2c-14-3f-d5")];
  sensors: sensor[] = []
  plantTypes: string[] = ["Kaktus", "Blume", "Frucht", "Beere", "Gemüse"]
  //--

  homeStation: homeStation | undefined;

  constructor(private route: ActivatedRoute, public sidenavService: SidenavService) {

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

  getSensors(homeStation: homeStation){
    return [new sensor("1e-43-5a-f3", "Tomaten"), new sensor("1e-43-5a-f3", "Kaktus")]
  }

  findHomeStation(serialNumber: string){
    return this.homeStations.find(h => h.serialnumber==serialNumber)
  }

}


