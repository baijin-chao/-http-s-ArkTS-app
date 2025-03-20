import http from '@ohos.net.http';
import { RequestOptions } from './RequestOptions';
import { ApiResult } from './ApiResult';
// 引入弹窗
import PreferenceUtil from './PreferenceUtil'
import promptAction from '@ohos.promptAction';
import { LoadingProgressDialog } from './LoadingProgressDialog';
import router from '@ohos.router';
import { LogUtil } from './LogUtil';
import { BASE_URL } from './Constants';
/**
 * Http请求器
 */
export class HttpCore {
  loadingDialog: CustomDialogController = new CustomDialogController({
    builder: LoadingProgressDialog(),//创建一个加载进度对话框的构建起
    alignment: DialogAlignment.Center,//对齐方式
    autoCancel: true,//自动取消对话框
    customStyle: true//自定义样式
  });


  /**
   * 发送请求
   * @param requestOption
   * @returns Promise
   */

  //用于发送 HTTP 请求。在方法中，首先创建了一个 httpRequest 实例，然后根据传入的 requestOptions 发起请求，并处理返回的数据。
  // 其中包括从本地存储中获取 token、设置请求头信息、解析返回数据、刷新 token、处理返回结果等逻辑。
  request(requestOptions: RequestOptions): Promise<ApiResult> {
    let p = new Promise<ApiResult>(async (resolve, reject) => {
      // 每一个httpRequest对应一个HTTP请求任务，不可复用
      let httpRequest = http.createHttp();
      let token = await PreferenceUtil.get("AccessToken","") as string;
      LogUtil.info("token", token)
      let requestUrl = requestOptions.url;
      if( !requestUrl.startsWith("http://") && !requestUrl.startsWith("https://") ){
        requestUrl = BASE_URL + requestOptions.url;
      }
      let data = await httpRequest.request(requestUrl, {
        method: requestOptions.method,
        connectTimeout: 60000,
        readTimeout: 60000,
        header: {
          'Content-Type': 'application/json',
          // 'Accesstoken': token,//用于验证用户身份和权限
          'X-Auth-Token': token,//用于验证用户身份和权限
          'client_type': 'HarmonyOS'
        },
        extraData: requestOptions.extraData
      });
      // LogUtil.info('success:' + data.result.toString());
      // let res = JSON.parse(data.result.toString());
      // let resultObj = res
      let ret = {
        responseCode: data.responseCode,
        header: data.header,
        cookies: data.cookies,
        result: data.result,
        resultObj: JSON.parse(data.result.toString())
      }
      resolve(ret as ApiResult);

      //如果业务码为20000 则返回ApiReslut

      // 根据状态码跳转登录页面
      // if (resultObj.code == 0){
      //   router.replaceUrl({
      //     url: "pages/LoginPage"
      //   }).then(() => {
      //     console.log('router successful')
      //   }).catch(err => {
      //     console.log('router err')
      //   })
      // }

      //解析数据并通过resolve返回值 错误则通过弹窗显示错误信息
      // if (res.Status == 0) {
      //   console.log(JSON.stringify(res))
      //   resolve(res);
      // }
      // else {
      //   promptAction.showToast({
      //     message: res.Msg
      //   })
      // }
      httpRequest.destroy();
    })
    return p;
  }
}

export const httpCore = new HttpCore();//导出一个有HTTP core实例的常量