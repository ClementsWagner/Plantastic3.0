import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import { NewUser } from 'src/app/interfaces';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-log-in',
  templateUrl: './log-in.component.html',
  styleUrls: ['./log-in.component.css']
})
export class LogInComponent{
  password: any;
  showSpinner: any;
  email: string = "";

  constructor(private client: HttpClient, private router: Router) {
  }

  login() {
    return this.client.put(`${environment.apiBase}/user/${this.email}`, this.password)
  }
}
