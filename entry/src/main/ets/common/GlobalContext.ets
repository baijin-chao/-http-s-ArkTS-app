
export default class GlobalContext {
  private constructor() {
  }

  private static instance: GlobalContext
  private _objects = new Map<string, Object>()//静态方法只能通过get方法获取单例实例

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext()
    }
    return GlobalContext.instance
  }//检查是否已经存在 GlobalContext 类的实例,如果存在该类实例则返回现有实例，没有则创建新的实例赋值给instance

  getObject(value: string): Object | undefined {
    return this._objects.get(value)
  }//获取存储在全局上下文中的对象

  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass)
  }//用于向全局上下文中存储对象，通过指定的键值对将对象添加到 Map 中。
}
//GlobalContext 类的作用是提供一个全局的存储空间，用于存储和管理全局对象。
// 通过单例模式，确保在应用程序中只有一个全局上下文实例，可以方便地在不同模块或组件中共享和访问全局对象