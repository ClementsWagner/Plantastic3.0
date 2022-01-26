import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SidenavService {

  open: boolean = false
  notify: boolean = false;

  constructor() { }

  hideNotify(){
    this.notify = false
  }

  showNotify(){
    this.notify = true
  }

  hideSidenav(){
    this.open = false
  }

  showSidenav(){
    this.open = true
  }

  toggleSidenav(){
    this.open = !this.open
  }

}
