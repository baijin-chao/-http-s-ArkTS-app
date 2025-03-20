import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import PreferenceUtil from '../common/PreferenceUtil'
export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    PreferenceUtil.createPreferences(this.context)
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }//在Ability创建时调用，通过PreferenceUtil.createPreferences方法创建一个偏好设置对象，
  // 并使用hilog.info输出日志信息"Ability onCreate"。

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }//在Ability销毁时调用，使用hilog.info输出日志信息"Ability onDestroy"。



  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    //在窗口阶段创建时调用，通过windowStage.loadContent方法加载页面"pages/Page1"，并根据加载结果输出相应的日志信息。

    windowStage.loadContent('pages/Page1', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }//在窗口阶段销毁时调用，使用hilog.info输出日志信息"Ability onWindowStageDestroy"。

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }//在Ability进入前台时调用，使用hilog.info输出日志信息"Ability onForeground"。

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }//在Ability进入后台时调用，使用hilog.info输出日志信息"Ability onBackground"。
}//这段代码主要实现了对Ability的生命周期和窗口管理的处理，通过日志输出来记录各个阶段的状态变化。
