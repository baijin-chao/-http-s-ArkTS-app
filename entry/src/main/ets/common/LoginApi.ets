import{Post,PostURL,Get,Param} from './aop'
import { ApiResult } from './ApiResult';

export class LoginApi {
  @Post("/users/login")
  //自定义@Param 作用：获取形参 便于映射到extraData
  login(@Param("Account") username: string, @Param("Password") password: string):Promise<ApiResult> {
    return
  }
  // @Get("/v5/iot/{project_id}/devices/{device_id}/shadow")
  @Get("https://fdd6b30522.iotda.cn-north-4.myhuaweicloud.com/v5/iot/2ad4f07d033b4246a75b19cd78c88180/devices/669b7557752c794e18d16b0d_traffic_light/shadow")
  //自定义@Param 作用：获取形参 便于映射到extraData
  loadData1():Promise<ApiResult> {
    return
  }
  // @Get("/v5/iot/{project_id}/devices/{device_id}/shadow")
  @Get("https://fdd6b30522.iotda.cn-north-4.myhuaweicloud.com/v5/iot/2ad4f07d033b4246a75b19cd78c88180/devices/669b7557752c794e18d16b0d_light/shadow")
  //自定义@Param 作用：获取形参 便于映射到extraData
  loadData2():Promise<ApiResult> {
    return
  }

  @Post("https://fdd6b30522.iotda.cn-north-4.myhuaweicloud.com/v5/iot/2ad4f07d033b4246a75b19cd78c88180/devices/669b7557752c794e18d16b0d_traffic_light/commands")
  //自定义@Param 作用：获取形参 便于映射到extraData
  banLu1(cmdParam: object):Promise<ApiResult> {
    return
  }
  @Post("https://fdd6b30522.iotda.cn-north-4.myhuaweicloud.com/v5/iot/2ad4f07d033b4246a75b19cd78c88180/devices/669b7557752c794e18d16b0d_light/commands")
  //自定义@Param 作用：获取形参 便于映射到extraData
  banLu2(cmdParam: object):Promise<ApiResult> {
    return
  }

  // @Post("/Cmds?deviceId=930047&apiTag=lu2&apiTag1=lu&apiTag2=tong")
  @PostURL("/Cmds")
  //自定义@Param 作用：获取形参 便于映射到extraData
  sendCmd(@Param("apiTag") apiTag: string, @Param("deviceId") deviceId: string):Promise<ApiResult> {
    return
  }

  @Post("https://iam.myhuaweicloud.com/v3/auth/tokens?nocatalog=true")
  //自定义@Param 作用：获取形参 便于映射到extraData
  getToken(auth: object):Promise<ApiResult> {
    return
  }
}
export const  loginApi = new LoginApi();
//以上代码展示了一个使用装饰器（Decorator）和自定义参数注解（@Param）的 TypeScript 类。
// 在这个示例中，LoginApi 类定义了三个方法，分别用于发起登录请求、加载数据和发送命令。每个方法都使用了装饰器（@Post 和 @Get）来指定请求的类型（POST 或 GET）和请求的路径。
// 同时，方法的参数使用了自定义参数注解 @Param 来指定参数的名称，以便将参数映射到请求的额外数据（extraData）中。