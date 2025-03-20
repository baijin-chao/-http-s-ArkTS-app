import { RequestMethod, RequestOptions } from './RequestOptions';
import { httpCore } from './HttpCore';
/**
 * <pre>
 * @desc       : 对外工具包
 * </pre>
 */
export class HttpUtil {
  private static mInstance: HttpUtil;

  // 防止实例化
  private constructor  () {

  }

  static getInstance(): HttpUtil {
    if (!HttpUtil.mInstance) {
      HttpUtil.mInstance = new HttpUtil();
    }
    return HttpUtil.mInstance;
  }

  request (option: RequestOptions) {
    return httpCore.request(option);
  }//request() 方法：该方法接收一个 RequestOptions 参数，然后调用 httpCore 实例的 request() 方法来发起 HTTP 请求，并返回请求的结果。

  /**
   * 封装Post网络请求
   * @param option
   * @returns
   */
  Post(option:RequestOptions){
    if(option != null){
      option.method = RequestMethod.POST
    }
    return this.request(option);
  }//该方法封装了一个 POST 请求的逻辑，
  // 将传入的 RequestOptions 参数的 method 字段设置为 RequestMethod.POST，
  // 然后调用 request() 方法发起请求并返回结果

  /**
   * 封装Get网络请求
   * @param option
   * @returns
   */
  Get(option:RequestOptions){

    if(option != null){
      option.method = RequestMethod.GET
    }
    return this.request(option);
  }



}

export const httpUtil = HttpUtil.getInstance();//导出的常量直接使用这个类的实例