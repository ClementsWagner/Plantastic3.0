import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NewUser } from 'src/app/models/new-user';
import { User } from 'src/app/models/user';
import { UserRestService } from 'src/app/services/Rest-services/user-rest.service';
import { UserService } from 'src/app/services/user.service';
import { CustomValidators } from 'src/app/providers/customValidator';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent{

  newUser: NewUser = {email: "", password: ""}
  user: User = {userId: 0, email: ""}

  signUpForm = new FormGroup({
    email: new FormControl("", [Validators.required, Validators.email]),
    password: new FormControl("", [Validators.required, Validators.minLength(8)]),
    confirmPassword: new FormControl("", Validators.required),
    });

  constructor(private userApi: UserRestService, private userService: UserService, private router: Router) {

  }

  signUp(){
    this.createUser()
  }

  createUser(){
    this.newUser.email = this.getFormfield("email")?.value
    this.newUser.password = this.getFormfield("password")?.value
    const result = this.userApi.addUser(this.newUser)
    result.subscribe(value => {
      this.user = value
      if(this.user.userId != 0){
        this.userService.email = this.user.email
        this.userService.userId = this.user.userId
        this.userService.isAuthenticated = true
        this.router.navigate(["/HomeStation"])
      }
    })
  }

  checkIfMatchingPasswords(passwordKey: string, passwordConfirmationKey: string){
    var password = this.getFormfield('passwordKey')?.value
    var confirmPassword = this.getFormfield('passwordConfirmationKey')?.value
    return password==confirmPassword
  }

  getFormfield(fieldName: string){
    return this.signUpForm.get(fieldName)
  }

  isFieldValid(fieldName: string){
    return !this.getFormfield(fieldName)?.valid && (this.getFormfield(fieldName)?.touched && this.getFormfield(fieldName)?.dirty)
  }

}
