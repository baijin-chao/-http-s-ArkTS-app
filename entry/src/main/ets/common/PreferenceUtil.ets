import dataPreferences from '@ohos.data.preferences'
import GlobalContext from './GlobalContext'
const LOG = 'PreferencesUtils-PUT'
// 默认文件名(数据库表名)，可以在构造函数进行修改
const PREFERENCES_NAME = 'scjgPreferences'
const KEY_PREFERENCES = 'preferences'
type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean>

class PreferencesUtil {
  // preferences的文件名-数据库表名
  private preferencesName: string = PREFERENCES_NAME
  // 用于获取preferences实例的key值，保存到单例中
  private keyPreferences: string = KEY_PREFERENCES

  constructor(name: string = PREFERENCES_NAME, key: string = KEY_PREFERENCES) {
    this.preferencesName = name
    this.keyPreferences = key
  }

  /**
   * 创建首选项实例
   * @param context: 应用上下文
   * @param preferencesName: 数据库表名
   * @returns
   */
  createPreferences(context): Promise<dataPreferences.Preferences> {
    let preferences = dataPreferences.getPreferences(context, this.preferencesName)
    GlobalContext.getContext().setObject(this.keyPreferences, preferences)
    return
  }

  /**
   * 获取首选项实例
   * @returns
   */
  getPreferences(): Promise<dataPreferences.Preferences> {
    return GlobalContext.getContext().getObject(this.keyPreferences) as Promise<dataPreferences.Preferences>
  }

  /**
   * 获取数据
   * @param key: 读取key值
   * @param def: 函数出参
   * @returns
   */
  async get(key: string, def?: ValueType): Promise<ValueType> {
    return (await this.getPreferences()).get(key, def)
  }

  // 获取全部数据
  async getAll(): Promise<Object> {
    let preferences = await this.getPreferences()
    return preferences.getAll()
  }

  /**
   * 插入数据
   * @param key: 存入key值
   * @param value: 存储数据
   * @returns
   */
  async put(key: string, value: ValueType): Promise<void> {
    let promise = await this.getPreferences().then(async preferences => {
      // 插入数据
      await preferences.put(key, value)
      // 写入文件
      await preferences.flush()
    }).catch(error => {
      console.log(error)
      // log.error(LOG, `code:${error.code}, message:${error.message}`)
    })
    return promise
  }

  /**
   * 删除数据
   * @param key: 删除key的value值
   * @returns
   */
  async delete(key: string): Promise<void> {//异步方法返回一个Promise<void>
    return (await this.getPreferences()).delete(key).finally(async () => {
      (await this.getPreferences()).flush()
    })
  }//await this.getPreferences()：调用 getPreferences 方法，该方法返回一个 Promise，在解析后会得到一个偏好设置对象。

  //.delete(key)：调用偏好设置对象的 delete 方法，传入要删除的键 key，删除存储在偏好设置中的指定键的值。该操作也返回一个 Promise。

  //.finally(async () => { (await this.getPreferences()).flush() })：使用 finally 方法，确保在删除操作完成后执行的回调函数。
  // 在这里，回调函数是一个异步函数，它会调用 flush 方法，该方法用于立即将所有未写入的更改保存到偏好设置中。

  // 清空数据
  async clear(): Promise<void> {
    return (await this.getPreferences()).clear().finally(async () => {
      (await this.getPreferences()).flush()
    })
  }
}

export default new PreferencesUtil()