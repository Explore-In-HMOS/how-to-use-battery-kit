import { BatteryTemperatureBuilder } from '../components/BatteryTemperature';
import { BatteryPowerBuilder } from '../components/BatteryPower';
import { BatterySOCBuilder } from '../components/BatterySOC';
import { BatteryHealthBuilder } from '../components/BatteryHealth';


@Entry
@Component
struct BatteryWidgetCard {
  /*
   * The action type.
   */
  readonly actionType: string = 'router';
  /*
   * The ability name.
   */
  readonly abilityName: string = 'EntryAbility';
  /*
   * The width percentage setting.
   */
  readonly fullWidthPercent: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly fullHeightPercent: string = '100%';

  build() {
    Stack() {

      GridRow({ columns: 2, gutter: { x: 2, y: 2 } }) {
        GridCol({ span: 1 }) {
          BatteryTemperatureBuilder()
        }
        .aspectRatio(1)

        GridCol({ span: 1 }) {
          BatterySOCBuilder()
        }
        .aspectRatio(1)

        GridCol({ span: 1 }) {
          BatteryHealthBuilder()
        }
        .aspectRatio(1)

        GridCol({ span: 1 }) {
          BatteryPowerBuilder()
        }
        .aspectRatio(1)
      }

      Button() {
        Text('🔄')
      }
      .backgroundColor('#0035ff00')
      .width(32)
      .height(32)
      .borderRadius(16)
      .alignSelf(ItemAlign.Center)
      .margin({ bottom: 8 })
      .onClick(() => {
        postCardAction(this, {
          action: 'message',
          params: { msgTest: 'messageEvent' }
        });
      })

    }
    .padding(7)
    .backgroundColor('#222831')
    .width(this.fullWidthPercent)
    .height(this.fullHeightPercent)
    .onClick(() => {
      postCardAction(this, {
        action: this.actionType,
        abilityName: this.abilityName,
      });
    })
  }
}