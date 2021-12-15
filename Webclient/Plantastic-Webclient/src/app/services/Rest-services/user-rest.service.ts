import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { NewUser } from 'src/app/models/new-user';
import { User } from 'src/app/models/user';
import { RestBase } from './rest-base';

@Injectable({
  providedIn: 'root'
})
export class UserRestService extends RestBase {

  constructor(protected http: HttpClient) {
    super(http, "/backend/user")
   }

   addUser(newUser: NewUser){
      return this.http.post<User>(this.serverUrl, newUser)
   }

   getUserByEmail(email: string): Observable<User>{
      let params = new HttpParams().set("email",email)
      return this.http.get<User>(this.serverUrl, {params: params})
   }
}
