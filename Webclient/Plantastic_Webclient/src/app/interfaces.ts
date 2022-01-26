export interface HomeStation{
    id: number
    userId: number
    name: string;
    serialnumber: string
  }

  export interface NewHomeStation{
    userId: number
    name: string;
    serialnumber: string
  }

  export interface NewSensor{
    homeStationId: number;
    name: string;
    power?: number;
    plantType?: string;
    status?: number
  }

  export interface NewUser{
    email: string
    password: string
  }

  export interface NotificationSummary{
    userId: number
    email: string
  }

  export interface Notification{
    userId: number
    homeStationId: number
    notification: boolean
  }

  export interface SensorResult{
    id: number
    name: string
    plantType: string
    homeStationId: number
  }

  export interface Sensor{
    id: number,
    homeStationId: number;
    name: string;
    power?: number;
    plantType?: string;
    status?: number
  }

  export interface User{
    id: number
    email: string
  }  