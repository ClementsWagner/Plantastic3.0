import { Component } from '@angular/core';
import {UserService} from "./services/user.service";
import {SidenavService} from "./services/sidenav.service";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Plantastic-Webclient';


  constructor(public userService: UserService, public  sidenavService: SidenavService) {
  }
}
