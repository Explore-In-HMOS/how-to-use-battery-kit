import { formBindingData, FormExtensionAbility, formInfo, formProvider } from '@kit.FormKit';
import { Want } from '@kit.AbilityKit';
import { getBatteryHealth, getBatteryPower, getBatterySoc, getBatteryTemperature } from '../lib/Battery';
import { hilog } from '@kit.PerformanceAnalysisKit';
import SOCModel from '../models/SOCModel';
import { BusinessError } from '@kit.BasicServicesKit';
import TemperatureModel from '../models/TemperatureModel';
import PowerModel from '../models/PowerModel';
import HealthModel from '../models/HealthModel';

const TAG: string = 'EntryFormAbility';
const DOMAIN_NUMBER: number = 0xFF00;

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    hilog.info(DOMAIN_NUMBER, TAG, '[EntryFormAbility] onAddForm');
    // Called to return a FormBindingData object.
    const formData = '';

    return formBindingData.createFormBindingData(formData);
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  private update(formId: string) {
    class FormDataClass {
      socModel: SOCModel = getBatterySoc()
      temperatureModel: TemperatureModel = getBatteryTemperature()
      powerModel: PowerModel = getBatteryPower()
      batteryHealthModel: HealthModel = getBatteryHealth()
    }

    let formData = new FormDataClass();
    let formInfo: formBindingData.FormBindingData = formBindingData.createFormBindingData(formData);
    formProvider.updateForm(formId, formInfo).then(() => {
      hilog.info(DOMAIN_NUMBER, TAG, 'FormAbility updateForm success.');
    }).catch((error: BusinessError) => {
      hilog.info(DOMAIN_NUMBER, TAG, `Operation updateForm failed. Cause: ${JSON.stringify(error)}`);
    })
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
    hilog.info(DOMAIN_NUMBER, TAG, `FormAbility onFormEvent, formId = ${formId}`);

    this.update(formId)
  }

  onFormEvent(formId: string, message: string) {
    // Called when a specified message event defined by the form provider is triggered.
    hilog.info(DOMAIN_NUMBER, TAG, `FormAbility onFormEvent, formId = ${formId}, message: ${JSON.stringify(message)}`);

    this.update(formId)
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.

  }


  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
}