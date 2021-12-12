export interface Sensor{
  id: number,
  homeStationId: number;
  name: string;
  power?: number;
  plantType?: string;
  status?: number
}
