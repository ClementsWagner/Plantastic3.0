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

  homeStations: HomeStation[] = [{id: 0, userId: 1, name: "Zuhause", serialnumber: "1e-43-5a-f3"}, {id: 0, userId: 1,name: "Büro", serialnumber: "2c-14-3f-d5"}];

  constructor(public dialog: MatDialog, public userService: UserService, public homestationRest: HomestationRestService) {

  }

  addHomestation(){
    let newHomestation: NewHomeStation
    let dialogRef = this.dialog.open(AddHomestationComponent, {
      height: '300px',
      width: '250px',
    });
    dialogRef.afterClosed().subscribe(result => {
      newHomestation = result
      if(newHomestation!=undefined && newHomestation.name!=undefined && newHomestation.serialnumber!=undefined){
        this.homestationRest.addHomestation(newHomestation)
      }
    })

  }

}
