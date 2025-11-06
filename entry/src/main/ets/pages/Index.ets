import { BatteryHealthBuilder } from '../batterywidget/components/BatteryHealth';
import { BatteryPowerBuilder } from '../batterywidget/components/BatteryPower';
import { BatterySOCBuilder } from '../batterywidget/components/BatterySOC';
import { BatteryTemperatureBuilder } from '../batterywidget/components/BatteryTemperature';
import { batteryInfo } from '@kit.BasicServicesKit';

const chargingStatusToText: Map<number, string> = new Map([
  [0, 'in unknown state'],
  [1, 'charging'],
  [2, 'not charging'],
  [3, 'fully charged'],
]);

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State chargingStatus: number = 0;

  aboutToAppear() {
    this.chargingStatus = batteryInfo.chargingStatus
    setInterval(async () => {
      const newChargingStatus = batteryInfo.chargingStatus
      if (newChargingStatus !== this.chargingStatus) {
        this.chargingStatus = newChargingStatus
      }
    }, 5_000) // check every 5 seconds
  }

  build() {

    Column() {
      Text('Battery Status')
        .padding(15)
        .fontWeight(FontWeight.Bold)
        .fontSize(22)
      GridRow({ columns: 4, gutter: { x: 2, y: 2 } }) {

        GridCol({ span: 1 }) {
          BatteryTemperatureBuilder(false)
        }
        .aspectRatio(1)

        GridCol({ span: 1 }) {
          BatterySOCBuilder(false)
        }
        .aspectRatio(1)

        GridCol({ span: 1 }) {
          BatteryHealthBuilder(false)
        }
        .aspectRatio(1)

        GridCol({ span: 1 }) {
          BatteryPowerBuilder(false)
        }
        .aspectRatio(1)
      }
      .height(50)

      Text(`Battery is ${chargingStatusToText.get(this.chargingStatus)}.`)
        .padding(7)
        .fontSize(12)
        .fontStyle(FontStyle.Italic)

    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .padding(7)
    .backgroundColor('#222831')
    .width('100%')
    .height('100%')

  }
}