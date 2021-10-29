export class sensor{
  get status(): number {
    return this._status;
  }

  private readonly _homeStationId: string;
  private _name: string;
  private readonly _power: number;
  private _plantType: string | undefined;
  private _status: number

  constructor(homeStationId: string, name: string) {
    this._power = 100;
    this._name = name
    this._homeStationId = homeStationId;
    this._status = 0;
  }

  get plantType(): string | undefined {
    return this._plantType;
  }

  set plantType(value: string | undefined) {
    this._plantType = value;
  }
  get power(): number {
    return this._power;
  }
  get name(): string {
    return this._name;
  }

  set name(value: string) {
    this._name = value;
  }
  get homeStationId(): string {
    return this._homeStationId;
  }
}
