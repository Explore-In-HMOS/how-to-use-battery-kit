import { getBatteryTemperature } from '../../lib/Battery';
import TemperatureModel from '../../models/TemperatureModel';

@Builder
export function BatteryTemperatureBuilder(isWidget: boolean = true) {
  BatteryTemperature({ isWidget })
}

@Component
struct BatteryTemperature {
  isWidget: boolean = true;
  @LocalStorageProp('temperatureModel') temperatureModel: TemperatureModel = getBatteryTemperature()

  constructor(isWidget: boolean) {
    super()
    this.isWidget = isWidget
  }

  aboutToAppear() {
    if (!this.isWidget) {
      this.temperatureModel = getBatteryTemperature()
      setInterval(async () => {
        const newTemperatureModel = getBatteryTemperature()
        if (newTemperatureModel.batteryTemperature !== this.temperatureModel.batteryTemperature) {
          this.temperatureModel = newTemperatureModel
        }
      }, 20_000)
    }
  }

  build() {
    Column() {
      Text(`Temperature`)
        .fontSize(7)
      Text(`${this.temperatureModel.batteryTemperature} °C`)
        .fontSize(16)
        .fontColor(Color.Orange)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .align(Alignment.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
