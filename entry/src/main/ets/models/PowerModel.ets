export default class PowerModel {
  voltage: number = 0;
  averageCurrent: number = 0;
  capacity: number = 0;
  batterySOC: number = 0;
  plugged: boolean = true

  constructor(
    voltage: number,
    averageCurrent: number,
    batterySOC: number,
    capacity: number,
    plugged: boolean
  ) {
    this.voltage = voltage
    this.averageCurrent = averageCurrent
    this.batterySOC = batterySOC
    this.capacity = capacity
    this.plugged = plugged
  }
}