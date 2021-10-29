import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import {ToolbarService} from "../../services/toolbar.service";


@Component({
  selector: 'app-log-in',
  templateUrl: './log-in.component.html',
  styleUrls: ['./log-in.component.css']
})
export class LogInComponent{
  password: any;
  showSpinner: any;
  email: string = "";

  constructor(public toolbarService: ToolbarService) {
  }

  login() {
    this.toolbarService.hideAuthentication(true)
  }
}
