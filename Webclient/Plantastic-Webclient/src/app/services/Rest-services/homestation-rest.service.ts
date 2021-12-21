import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { NewHomeStation } from 'src/app/models/new-home-station';
import { RestBase } from './rest-base';

@Injectable({
  providedIn: 'root'
})
export class HomestationRestService extends RestBase {

  constructor(protected http: HttpClient) {
    super(http, "backend/homestation")
   }

   getHomestations(userId: number){

   }

   addHomestation(newHomestation: NewHomeStation, userId: number){

   }


}
