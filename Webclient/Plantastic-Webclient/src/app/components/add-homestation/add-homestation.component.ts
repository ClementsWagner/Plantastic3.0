import { Component, OnInit } from '@angular/core';
import { NewHomeStation } from 'src/app/models/new-home-station';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-add-homestation',
  templateUrl: './add-homestation.component.html',
  styleUrls: ['./add-homestation.component.css']
})
export class AddHomestationComponent implements OnInit {

  newHomestation: NewHomeStation

  constructor(public userService: UserService) {
    this.newHomestation = {userId: this.userService.userId,name: "", serialnumber: ""}
  }

  ngOnInit(): void {
  }

}
