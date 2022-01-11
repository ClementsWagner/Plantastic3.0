import { Component, OnInit } from '@angular/core';
import {HomeStation} from "../../models/home-station";
import { ActivatedRoute } from "@angular/router";
import { MatDialog } from '@angular/material/dialog';
import { AddHomestationComponent } from '../add-homestation/add-homestation.component';
import { NewHomeStation } from 'src/app/models/new-home-station';
import { UserService } from 'src/app/services/user.service';
import { HomestationRestService } from 'src/app/services/Rest-services/homestation-rest.service';

@Component({
  selector: 'app-home-station',
  templateUrl: './home-station.component.html',
  styleUrls: ['./home-station.component.css']
})
export class HomeStationComponent {

  homeStations: HomeStation[] = []

  constructor(public dialog: MatDialog, public userService: UserService, public homestationRest: HomestationRestService) {
    this.loadHomeStations()
  }

  loadHomeStations(){
    this.homestationRest.getHomestations(this.userService.userId).subscribe(value => this.homeStations=value)
  }

  addHomestation(){
    let newHomestation: NewHomeStation
    let dialogRef = this.dialog.open(AddHomestationComponent, {
      height: '300px',
      width: '250px',
    });
    dialogRef.afterClosed().subscribe(result => {
      newHomestation = result
      newHomestation.userId = this.userService.userId
      console.log(this.userService.email)
      console.log(this.userService.userId)
      if(newHomestation!=undefined && newHomestation.name!=undefined && newHomestation.serialnumber!=undefined){
        console.log(newHomestation)
        this.homestationRest.addHomestation(newHomestation).subscribe(() => this.loadHomeStations())
      }
    })
  }

}
