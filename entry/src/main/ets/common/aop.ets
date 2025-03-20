import { ApiResult } from './ApiResult';
import { httpUtil } from './HttpUtil';
import { RequestOptions } from './RequestOptions';

/**
 * 利用Map保存参数和值的映射关系  为避免参数名及方法名重复 采用组合Key的方法
 */
type FunParamMapKey = {
  target: Object; //所在类
  methodName: string; //所在方法
  index: number; //参数名索引值
}

let funParamMap = new Map<string, string>();
//内存 Map 存储参数映射关系：为了避免参数名和方法名重复，采用组合 Key 的方法构建 FunParamMapKey 对象，将参数名和值存储在内存 Map 中。
// 在 Get 和 Post 装饰器中，通过组合 Key 从内存 Map 中获取 @Param 注解修饰的参数名，并将参数值添加到请求配置中。

// @Get注解 拿到url 从函数的@Param拿到参数名及参数值 利用HttpUtil进行网络请求
//Get 需要拼接URl
export function Get(url: string) {
  return function (target: any, methodName: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    let URL: string = url;
    let options: RequestOptions = {
      url: URL,
      queryParams: {}
    };
    descriptor.value = async function (...args: any[]) {
      //对于方法中的每一个（methodName，arg）遍历加入到网络请求配置中
      args.forEach((arg, index) => {
        // 通过已知的信息构造组合Key对象
        let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
        // 通过组合Key（通过对内容的比较而不是值 节省内存）从内存map中获取@Param修饰的内容
        let paramName = funParamMap[JSON.stringify(obj)];
        // 将正确的参数名及值添加至网络请求参数中
        if (typeof paramName !== 'undefined') {
          if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer || typeof arg === 'number') {
            options.queryParams[paramName] = arg
          } else {
            console.log('参数类型不对')
            throw new Error(`Invalid parameter type at index ${index}.`);
          }
        }
      });
      //拼接请求参数
      const urlParams = Object.keys(options.queryParams).map(key => `${key}=${options.queryParams[key]}`).join('&')
      console.log('urlParams:', urlParams)
      if (URL.includes("/")) {
        options.url = `${URL}${urlParams}`
      } else {
        options.url = `${URL}/${urlParams}`
      }

      const p = new Promise<ApiResult>((resolve, reject) => {
        httpUtil.Get(options).then((response) => {
          const result: ApiResult = response;
          resolve(result);
        }).catch((error) => {
          reject(error);
        });
      });
      return await p;
    };
  };
}

// @Post注解 拿到url 从函数的@Param拿到参数名及参数值 利用HttpUtil进行Post网络请求
export function Post(url: string) {
  return function (target: any, methodName: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    let options: RequestOptions = {
      url: url,
      extraData: {}
    };
    descriptor.value = async function (...args: any[]) {
      //对于方法中的每一个（methodName，arg）遍历加入到网络请求配置中
      args.forEach((arg, index) => {
        console.log("参数值",JSON.stringify(arg))
        // 通过已知的信息构造组合Key对象
        let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
        // 通过组合Key（通过对内容的比较而不是值 节省内存）从内存map中获取@Param修饰的内容
        let paramName = funParamMap[JSON.stringify(obj)];
        console.log("参数名：",paramName)
        // 将正确的参数名及值添加至网络请求参数中
        if (typeof paramName !== 'undefined') {
          if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer) {
            options.extraData[paramName] = arg;
          } else {
            throw new Error(`Invalid parameter type at index ${index}.`);
          }
        }else {
          //如果获取不到形参名 及未被@Param标记 并且参数的类型是对象
          if (typeof  arg === 'object') {
            options.extraData = JSON.stringify(arg)
          }
        }
      });
      console.log('extraData', JSON.stringify(options.extraData))
      const p = new Promise<ApiResult>((resolve, reject) => {
        httpUtil.Post(options).then((response) => {
          const result: ApiResult = response;
          resolve(result);
        }).catch((error) => {
          reject(error);
        });
      });
      return await p;
    };
  };
}


//Get 和 Post 装饰器：这两个装饰器用于指定请求的类型（GET 或 POST）和请求的路径，
// 并通过自定义的 @Param 注解获取方法的参数名和参数值，将参数映射到请求的配置中。
// 在装饰器中，会根据参数名和值构建请求配置对象，并调用 HttpUtil 中的方法发起网络请求。

// @PostURL注解 拿到url 从函数的@Param拿到参数名及参数值拼接url 利用HttpUtil进行Post网络请求
export function PostURL(url: string) {
  return function (target: any, methodName: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    let URL: string = url;
    let options: RequestOptions = {
      url: URL,
      extraData: {},
      queryParams: {}
    };
    descriptor.value = async function (...args: any[]) {
      options.queryParams = {}
      //对于方法中的每一个（methodName，arg）遍历加入到网络请求配置中
      args.forEach((arg, index) => {
        console.log("参数值",JSON.stringify(arg))
        // 通过已知的信息构造组合Key对象
        let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
        // 通过组合Key（通过对内容的比较而不是值 节省内存）从内存map中获取@Param修饰的内容
        let paramName = funParamMap[JSON.stringify(obj)];
        console.log("参数名：",paramName)
        // 将正确的参数名及值添加至网络请求参数中
        if (typeof paramName !== 'undefined') {
          if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer) {
            options.extraData[paramName] = arg;
            options.queryParams[paramName] = arg
          } else {
            throw new Error(`Invalid parameter type at index ${index}.`);
          }
        }else {
          //如果获取不到形参名 及未被@Param标记 并且参数的类型是对象
          if (typeof  arg === 'object') {
            options.extraData = JSON.stringify(arg)
          }
        }
      });
      console.log('extraData', JSON.stringify(options.extraData))

      //拼接请求参数
      const urlParams = Object.keys(options.queryParams).map(key => `${key}=${options.queryParams[key]}`).join('&')
      if (URL.includes("?")) {
        options.url = `${URL}${urlParams}`
      } else {
        options.url = `${URL}?${urlParams}`
      }

      const p = new Promise<ApiResult>((resolve, reject) => {
        httpUtil.Post(options).then((response) => {
          const result: ApiResult = response;
          resolve(result);
        }).catch((error) => {
          reject(error);
        });
      });
      return await p;
    };
  };
}


/**
 * @Param 注解将想要获取的Param添加至内存Map中
 * @param paramName
 * @returns
 */
export function Param(paramName: string) {
  return function (target: any, methodName: string, parameterIndex: number) {
    let obj: FunParamMapKey = { target: target, methodName: methodName, index: parameterIndex };
    funParamMap[JSON.stringify(obj)] = paramName;
  };
}
//Param 注解：Param 注解用于标记方法的参数，指定参数的名称，
// 以便在 Get 和 Post 装饰器中根据参数名获取参数值，并将参数名和值映射到请求配置中。



//实现通过装饰器和自定义参数注解简化网络请求配置和参数传递的方法