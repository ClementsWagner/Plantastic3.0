import { HttpClient } from "@angular/common/http"

export class RestBase{
  serverUrl: string
  route?: string

  constructor(protected http: HttpClient, route: string){
    this.route = route
    this.serverUrl = "http://localhost:4000/" + route
  }
}
