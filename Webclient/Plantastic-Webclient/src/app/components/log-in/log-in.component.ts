import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import {UserService} from "../../services/user.service";


@Component({
  selector: 'app-log-in',
  templateUrl: './log-in.component.html',
  styleUrls: ['./log-in.component.css']
})
export class LogInComponent{
  password: any;
  showSpinner: any;
  email: string = "";

  constructor(public userService: UserService) {
  }

  login() {
    this.userService.email = this.email;
    this.userService.isAuthenticated = true
  }
}
