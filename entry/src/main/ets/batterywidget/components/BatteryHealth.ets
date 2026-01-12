import { getBatteryHealth } from '../../lib/Battery';
import HealthModel from '../../models/HealthModel';

@Builder
export function BatteryHealthBuilder(isWidget: boolean = true) {
  BatteryHealth({ isWidget })
}


const colorToEmoji: Map<Color, string> = new Map([
  [Color.Red, '❤️'],
  [Color.Yellow, '💛'],
  [Color.Gray, '🤍'],
  [Color.Black, '🖤']
]);

@Component
struct BatteryHealth {
  isWidget: boolean = true;
  @LocalStorageProp('batteryHealthModel') batteryHealthModel: HealthModel = getBatteryHealth()

  constructor(isWidget: boolean) {
    super()
    this.isWidget = isWidget
  }

  aboutToAppear() {
    if (!this.isWidget) {
      this.batteryHealthModel = getBatteryHealth()
      setInterval(async () => {
        const newHealthModel = getBatteryHealth()
        if (newHealthModel.health !== this.batteryHealthModel.health) {
          this.batteryHealthModel = newHealthModel
        }
      }, 60_000)
    }
  }

  build() {

    Column() {
      Text(colorToEmoji.get(this.batteryHealthModel.color))
        .fontSize(20)
      Text(`${this.batteryHealthModel.health}`)
        .fontSize(10)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')

  }
}
