import hilog from '@ohos.hilog';

export class LogUtil {
  private static domain: number = 0xFF00;//指定日志的域
  private static prefix: string = '智慧交通';//标识信息的来源或模块名称
  private static format: string = '%{public}s, %{public}s';//指定日志消息的格式

  static debug(...args: string[]): void {
    hilog.debug(LogUtil.domain, LogUtil.prefix, LogUtil.format, args);
  }

  static info(...args: string[]): void {
    hilog.info(LogUtil.domain, LogUtil.prefix, LogUtil.format, args);
  }

  static warn(...args: string[]): void {
    hilog.warn(LogUtil.domain, LogUtil.prefix, LogUtil.format, args);
  }

  static error(...args: string[]): void {
    hilog.error(LogUtil.domain, LogUtil.prefix, LogUtil.format, args);
  }
}