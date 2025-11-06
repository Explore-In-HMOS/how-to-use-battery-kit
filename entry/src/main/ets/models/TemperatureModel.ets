export default class TemperatureModel {
  batteryTemperature: number = 0;

  constructor(
    batteryTemperature: number
  ) {
    this.batteryTemperature = batteryTemperature;
  }
}