import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private _userId: number
  private _isAuthenticated: boolean;
  private _email: string

  constructor() {
    this._isAuthenticated = false
    this._email = ""
    this._userId = 0
  }

  get userId(): number{
    return this._userId
  }

  setUserId(value: number){
    this._userId = value
    console.log("Set UserId:")
    console.log(value)
  }

  set userId(value: number){
    this._userId = value
    console.log("Set Id:")
    console.log(value)
  }

  get isAuthenticated(): boolean {
    return this._isAuthenticated;
  }

  set isAuthenticated(value: boolean) {
    this._isAuthenticated = value;
  }

  get email(): string {
    return this._email;
  }

  set email(value: string) {
    this._email = value;
    console.log("Set Email:")
    console.log(value)
  }
}
