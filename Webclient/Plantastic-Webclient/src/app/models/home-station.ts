export class homeStation{

  private _active: boolean;
  private _name: string;
  readonly _serialnumber: string

  constructor(name: string, serialnumber: string) {
    this._name = name;
    this._serialnumber = serialnumber;
    this._active = false;
  }

  get active(): boolean {
    return this._active;
  }

  set active(value: boolean) {
    this._active = value;
  }

  get serialnumber(): string {
    return this._serialnumber;
  }
  get name(): string {
    return this._name;
  }

  set name(value: string) {
    this._name = value;
  }
}
