import { Component } from '@angular/core';
import {ToolbarService} from "./services/toolbar.service";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Plantastic-Webclient';
  sidenavOpened: boolean = false;

  constructor(public toolbarService: ToolbarService) {
  }

  sidenavChangeState() {
    this.sidenavOpened = !this.sidenavOpened
  }
}
