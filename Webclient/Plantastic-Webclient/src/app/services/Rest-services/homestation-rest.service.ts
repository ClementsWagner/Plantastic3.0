import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HomeStation } from 'src/app/models/home-station';
import { NewHomeStation } from 'src/app/models/new-home-station';
import { RestBase } from './rest-base';

@Injectable({
  providedIn: 'root'
})
export class HomestationRestService extends RestBase {

  constructor(protected http: HttpClient) {
    super(http, "/backend/HomeStation")
   }

   //To do add userId parameter
   getHomestations(userId: number):Observable<HomeStation[]>{
    return this.http.get<HomeStation[]>(this.serverUrl)
   }

   addHomestation(newHomestation: NewHomeStation){
    return this.http.post(this.serverUrl, newHomestation)
   }


}
