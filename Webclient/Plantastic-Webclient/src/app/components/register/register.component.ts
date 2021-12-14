import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NewUser } from 'src/app/models/new-user';
import { User } from 'src/app/models/user';
import { UserRestService } from 'src/app/services/Rest-services/user-rest.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent{

  newUser: NewUser = {email: "", password: ""}
  user: User = {userId: 0, email: ""}

  constructor(private userApi: UserRestService, private userService: UserService, private router: Router) {
    console.log(userApi)
  }

  signUp(){
    this.createUser()

    if(this.user != undefined){

      this.userService.email = this.user.email
      this.userService.userId = this.user.userId
      this.userService.isAuthenticated = true
      this.router.navigate(["/HomeStation"])
    }
  }

  createUser(){
    const result = this.userApi.addUser(this.newUser)
    result.subscribe(value => this.user = value)
  }

}
