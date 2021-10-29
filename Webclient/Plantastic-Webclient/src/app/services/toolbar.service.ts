import { Injectable } from '@angular/core';
import {Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class ToolbarService {

  isAuthenticated: boolean;

  constructor() {
    this.isAuthenticated = false
  }

  hideAuthentication(state: boolean){
    this.isAuthenticated = state;
  }
}
