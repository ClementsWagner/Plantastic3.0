import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Sensor } from 'src/app/models/sensor';
import { RestBase } from './rest-base';

@Injectable({
  providedIn: 'root'
})
export class SensorRestService extends RestBase {

  constructor(protected http: HttpClient) {
    super(http, "/backend/Sensor")
   }

  getSensors(homestationId: number): Observable<Sensor[]>{
    return this.http.get<Sensor[]>(this.serverUrl)
  }

}
