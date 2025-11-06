import { getBatterySoc } from '../../lib/Battery';
import SOCModel from '../../models/SOCModel';

@Builder
export function BatterySOCBuilder(isWidget: boolean = true) {
  BatterySOC({ isWidget });
}

@Component
struct BatterySOC {
  isWidget: boolean = true;
  @LocalStorageProp('socModel') socModel: SOCModel = getBatterySoc();

  constructor(isWidget: boolean) {
    super()
    this.isWidget = isWidget
  }

  aboutToAppear() {
    if (!this.isWidget) {
      this.socModel = getBatterySoc()
      setInterval(async () => {
        const newSocModel = getBatterySoc()
        if (newSocModel.socModel !== this.socModel.socModel) {
          this.socModel = newSocModel
        }
      }, 5_000) // check every 5 seconds
    }
  }

  build() {
    Column() {
      // Circular progress panel showing battery SOC
      Stack() {
        DataPanel({
          values: [this.socModel.socModel], // current SOC
          max: 100, // max 100%
          type: DataPanelType.Circle, // circular progress
        })
          .valueColors([this.getColor(this.socModel.socModel)]) // dynamic color based on SOC
          .width(40)
          .height(40)
          .strokeWidth(4)


        // Text percentage below the panel
        Text(`${this.socModel.socModel}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White);
      }
    }
    .align(Alignment.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  // Optional: return color based on SOC level
  private getColor(soc: number): string {
    if (soc > 80) {
      return '#4CAF50';
    } // green
    if (soc > 50) {
      return '#FFC107';
    } // yellow
    if (soc > 20) {
      return '#FF9800';
    } // orange
    return '#F44336'; // red
  }
}