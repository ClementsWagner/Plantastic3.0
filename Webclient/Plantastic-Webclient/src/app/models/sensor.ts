export interface Sensor{
  readonly homeStationId: string;
  name: string;
  readonly power?: number;
  plantType?: string;
  status?: number
}
