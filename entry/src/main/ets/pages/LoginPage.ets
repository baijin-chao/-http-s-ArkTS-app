/**登录页面*/
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { loginApi } from '../common/LoginApi'
import { httpUtil } from '../common/HttpUtil'
import PreferenceUtil from '../common/PreferenceUtil'

@Entry
@Component
struct Page2 {
  @State UserName: string = "13776273053"
  @State password: string = "13921974201m"
  @State tishi: string = "登录失败"
  public readonly authObj = {
    "auth": {
      "identity": {
        "methods": [
          "password"
        ],
        "password": {
          "user": {
            "name": "xuhai",
            "password": "xuhai_iot",
            "domain": {
              "name": "hid_j8dot770kqqksv4"
            }
          }
        }
      },
      "scope": {
        "project": {
          "name": "cn-north-4"
        }
      }
    }
  }

  build() {
    Column() {
      Row() {
        Image($r("app.media.xiaohui")).width(100)
        Row().width("20%")
        Image($r("app.media.logo666")).height(70)
          .margin({ bottom: 80, top: 80 })
      }.margin({ top: 60 })

      Row() {
        Image($r("app.media.zhanghao")).width(30)
        TextInput({ placeholder: "请输入账号", text: this.UserName }).flexBasis(280)
          .backgroundColor("#ffd0e7fa")
          .onChange((val) => {
            this.UserName = val
          })
      }.width("90%").justifyContent(FlexAlign.SpaceBetween).margin({ top: 40 })

      Row() {
        Image($r("app.media.mima")).width(30)
        TextInput({ placeholder: "请输入密码", text: this.password }).flexBasis(280)
          .backgroundColor("#ffd0e7fa").type(InputType.Password)
          .onChange((val) => {
            this.password = val
          })
      }.width("90%").justifyContent(FlexAlign.SpaceBetween).margin({ top: 18, bottom: 10 })


      Button("login").width("90%")
        .onClick(async () => {

          loginApi.getToken(this.authObj).then((res) => {
            if(res.responseCode==201){
              PreferenceUtil.put('AccessToken', res.header['x-subject-token'])
              router.pushUrl({url:"pages/Index"})
            } else {
              promptAction.showToast({
                message: res.result
              })
            }

          }).catch(err => {
            console.log(err)
          })


          // let res=await httpUtil.Post({
          //   url:"/users/login",
          //   extraData:{
          //     "Account":this.UserName,
          //     "Password":this.password
          //   }
          // });
          // let res=await loginApi.login(this.UserName,this.password)
          // //调用loginApi.login方法，传入用户名(this.UserName)和密码(this.password)作为参数，使用await关键字等待异步操作完成并获取返回结果。
          // if(res.Status==0){
          //   router.pushUrl({url:"pages/Index"})//如果返回结果res中的Status为0，表示登录成功，调用router.pushUrl方法跳转到页面"pages/Index
          // }else{
          //   promptAction.showToast({//如果返回结果res中的Status不为0，表示登录失败，调用promptAction.showToast方法显示一个提示消息，消息内容为res中的Msg
          //     message:res.Msg
          //   })
          // }
        })
        .margin({ top: 40 })
    }.justifyContent(FlexAlign.Center).width("100%")

  }
}