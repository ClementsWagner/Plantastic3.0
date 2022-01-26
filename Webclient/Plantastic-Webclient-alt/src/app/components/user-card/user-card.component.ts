import { Component, OnInit } from '@angular/core';
import {UserService} from "../../services/user.service";
import {SidenavService} from "../../services/sidenav.service";

@Component({
  selector: 'app-user-card',
  templateUrl: './user-card.component.html',
  styleUrls: ['./user-card.component.css']
})
export class UserCardComponent {

  constructor(public userService: UserService, public sidenavService: SidenavService) { }

  logOut() {
    this.userService.isAuthenticated = false
    this.sidenavService.hideSidenav()
  }
}
