import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NewUser } from 'src/app/models/new-user';
import { User } from 'src/app/models/user';
import { UserRestService } from 'src/app/services/Rest-services/user-rest.service';
import { UserService } from 'src/app/services/user.service';
import { CustomValidators } from 'src/app/providers/customValidator';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.css']
})
export class SignUpComponent{

  newUser: NewUser = {email: "", password: ""}
  user: User = {id: 0, email: ""}

  signUpForm = new FormGroup({
    email: new FormControl("", [Validators.required, Validators.email]),
    password: new FormControl("", [Validators.required, Validators.minLength(8)]),
    confirmPassword: new FormControl("", Validators.required),
    });

  constructor(private client: HttpClient, private router: Router, private userService: UserService) {

  }

  signUp(){
    this.newUser.email = this.getFormfield("email")?.value
    this.newUser.password = this.getFormfield("password")?.value
    this.client.post(`${environment.apiBase}/user/`, this.newUser).subscribe(value => {
      this.user = value
      console.log(value)
      if(this.user.id != 0){
        this.userService.email = this.user.email
        this.userService.userId = this.user.id
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
