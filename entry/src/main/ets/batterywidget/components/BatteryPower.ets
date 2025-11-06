import { getBatteryPower, estimateRemaining } from '../../lib/Battery';
import PowerModel from '../../models/PowerModel';

@Builder
export function BatteryPowerBuilder(isWidget: boolean = true) {
  BatteryPower({ isWidget })
}

@Component
struct BatteryPower {
  isWidget: boolean = true;
  @LocalStorageProp('powerModel') powerModel: PowerModel = getBatteryPower()

  constructor(isWidget: boolean) {
    super()
    this.isWidget = isWidget
  }

  aboutToAppear() {
    if (!this.isWidget) {
      this.powerModel = getBatteryPower()
      setInterval(async () => {
        const newPowerModel = getBatteryPower()
        if (newPowerModel.batterySOC !== this.powerModel.batterySOC) {
          this.powerModel = newPowerModel
        }
      }, 5_000) // check every 5 seconds
    }
  }

  private getRemainingTime(): string {
    let hours = estimateRemaining(this.powerModel)
    const days = Math.floor(hours / 24);
    const remainingHours = Math.floor(hours % 24);
    const minutes = Math.round((hours - Math.floor(hours)) * 60);

    // Build formatted string
    let result = "";
    if (days > 0) {
      result += `${days}d`;
    }
    if (remainingHours > 0 || days > 0) {
      result += `${remainingHours}h`;
    }
    if (minutes > 0) {
      result += `${minutes}m`;
    }

    return result || "0m"; // fallback if everything is 0
  }

  build() {
    Column() {
      Text('Remaining Time')
        .fontSize(9)
      Text(`${this.getRemainingTime()}`)
        .fontSize(9)
        .fontColor(Color.Orange)
    }
    .align(Alignment.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}