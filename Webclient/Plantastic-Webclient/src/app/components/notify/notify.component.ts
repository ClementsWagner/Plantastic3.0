import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-notify',
  templateUrl: './notify.component.html',
  styleUrls: ['./notify.component.css']
})
export class NotifyComponent {

  notifies: string[] = ['Peter@gmail.com', 'Mama@gmail.at']
  adding: boolean = false;
  newEmail: string = "";


  constructor() { }

  delete(item: string) {
    const index = this.notifies.indexOf(item)
    this.notifies.splice(index, 1)
  }

  add(){
    this.adding = false
    this.notifies.push(this.newEmail)
    this.newEmail = ""
  }

  onAdd() {
    this.adding = true
  }
}
