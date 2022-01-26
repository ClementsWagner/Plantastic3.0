import { HttpClient, HttpHeaders, HttpParamsOptions } from "@angular/common/http"

export class RestBase{
  //host: string = "61b6229cc95dd70017d40e64.mockapi.io"
  host: string = "localhost:7246"
  serverUrl: string
  route?: string


  constructor(protected http: HttpClient, route: string){
    this.route = route
    this.serverUrl = "https://" + this.host + route
  }
}
