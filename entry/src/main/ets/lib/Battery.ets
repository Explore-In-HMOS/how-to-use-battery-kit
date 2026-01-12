import { batteryInfo } from '@kit.BasicServicesKit';
import PowerModel from '../models/PowerModel';
import TemperatureModel from '../models/TemperatureModel';
import deviceInfo from '@ohos.deviceInfo';
import SOCModel from '../models/SOCModel';
import HealthModel from '../models/HealthModel';

export function getBatteryTemperature(): TemperatureModel {
  return new TemperatureModel(batteryInfo.batteryTemperature / 10)
}

export function getBatterySoc(): SOCModel {
  return new SOCModel(batteryInfo.batterySOC)
}

export function getBatteryHealth(): HealthModel {
  const healthStatus: number = batteryInfo.healthStatus;

  let healthString: string;
  let color: Color = Color.Yellow;

  switch (healthStatus) {
    case batteryInfo.BatteryHealthState.UNKNOWN:
      healthString = 'Unknown';
      color = Color.Grey;
      break;
    case batteryInfo.BatteryHealthState.GOOD:
      healthString = 'Good';
      color = Color.Red;
      break;
    case batteryInfo.BatteryHealthState.OVERHEAT:
      healthString = 'Overheat';
      break;
    case batteryInfo.BatteryHealthState.OVERVOLTAGE:
      healthString = 'Overvoltage';
      break;
    case batteryInfo.BatteryHealthState.COLD:
      healthString = 'Cold';
      break;
    case batteryInfo.BatteryHealthState.DEAD:
      healthString = 'Dead';
      color = Color.Black;
      break;
    default:
      healthString = 'Unknown';
      color = Color.Grey;
  }
  return new HealthModel(healthString, color)
}

export function getBatteryPower(): PowerModel {
  return new PowerModel(
    batteryInfo.voltage,
    batteryInfo.nowCurrent,
    batteryInfo.batterySOC,
    batteryInfo.batteryCapacityLevel,
    batteryInfo.pluggedType === 0 ? false : true
  );
}


export function estimateRemaining(powerModel: PowerModel) {
  const batteryCapacity = 867; // 540 mAh for 42mm Huawei Watch 5

  let current = powerModel.averageCurrent; // according to docs, batteryInfo.nowCurrent is unit of mA
  if (deviceInfo.productModel === 'emulator') {
    // However, batteryInfo.nowCurrent returns 900000 in the emulator. Assume it is 9mA
    current = 9;
  }

  const hours = (batteryCapacity * (powerModel.batterySOC / 100)) / current;
  return hours; // in hours
}
