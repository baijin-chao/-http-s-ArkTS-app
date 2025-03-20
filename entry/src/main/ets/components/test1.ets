// @ts-nocheck
// @ts-nocheck
// @ts-nocheck
import { LogUtil } from '../common/LogUtil';
import { loginApi } from '../common/LoginApi';
import PreferenceUtil from '../common/PreferenceUtil'
import promptAction from '@ohos.promptAction';
import fetch from '@system.fetch';
import { Level } from '@ohos/hypium';
import { ApiResult } from '../common/ApiResult';
import http from '@ohos.net.http';

@Component
export default struct Test1 {
  @State selectIndex: number = 0//状态变量
  @State message: string = '定时器'
  @State cot: number = 0
  @State deng: number = 0
  @State deng2: number = 0
  @State deng3: number = 0
  @State deng4: number = 0
  @State deng5: number = 0
  @State deng6: number = 0
  @State deng7: number = 0
  @State deng8: number = 0
  @State time: number = 60
  @State time2: number = 60
  @State time3:number=60
  @State time4:number=60
  @State time5:number=60
  @State time6:number=60
  @State time7:number=60
  @State time8:number=60
  @State tong: number = 1
  @State carNumber: number = 60
  @State carNumber2: number = 60
  @State carNumber3: number = 60
  @State carNumber4: number = 60
  @State carNumber5: number = 60
  @State carNumber6: number = 60
  @State carNumber7: number = 60
  @State carNumber8: number = 60
  @State dengStr: string = 'red light'
  @State dengStr2: string = 'red light'
  @State dengStr3: string = 'red light'
  @State dengStr4: string = 'red light'
  @State dengStr5: string = 'red light'
  @State dengStr6: string = 'red light'
  @State dengStr7: string = 'red light'
  @State dengStr8: string = 'red light'
  @State dengImg: Resource = $r("app.media.hong")
  @State dengImg2: Resource = $r("app.media.hong")
  @State dengImg3: Resource = $r("app.media.hong")
  @State dengImg4: Resource = $r("app.media.hong")
  @State dengImg5: Resource = $r("app.media.hong")
  @State dengImg6: Resource = $r("app.media.hong")
  @State dengImg7: Resource = $r("app.media.hong")
  @State dengImg8: Resource = $r("app.media.hong")
  @State stop_timer: boolean = false;
  @State level:number=60
  @State level2:number=45
  control: TabsController = new TabsController();
  @State device_id:string="";
  @State service_id:string="";
  @State main_user:string="";
  @State project_id:string="";
  @State server_id:string="";
  @State iam_user:string="";
  @State iam_password:string="";
  @State ip_addr:String=""

  // public readonly IAM_URL:string = "https://iam.myhuaweicloud.com/v3/auth/tokens?nocatalog=true"
  // public readonly SHADOW_URL:string = "https://fdd6b30522.iotda.cn-north-4.myhuaweicloud.com/v5/iot/2ad4f07d033b4246a75b19cd78c88180/devices/669b7557752c794e18d16b0d_traffic_light/shadow"
  // public readonly IAM_USERNAME:string = "xuhai"
  // public readonly IAM_PASSWORD:string = "xuhai_iot"
  // public readonly IAM_DOMAIN:string = "hid_j8dot770kqqksv4"
  // public readonly PROJECT_NAME:string = "cn-north-4"

  aboutToAppear() {//在此函数中调用startCount方法，然后使用PreferenceUtil类存储用户的偏好设置
    this.startCount()
    PreferenceUtil.put('userName', '张三')
    PreferenceUtil.put('age', '24')
    PreferenceUtil.put('sex', '男')
  }

  async getAll() {//异步函数
    //首先，使用await关键字调用PreferenceUtil.getAll()方法来获取所有的用户偏好设置，并将结果转换为JSON字符串，存储在变量ts中。
    let ts = JSON.stringify(await PreferenceUtil.getAll() as Object)
    //使用LogUtil.info()方法输出日志，记录获取到的所有用户偏好设置。
    LogUtil.info('getAll', ts)
    //使用await关键字调用PreferenceUtil.get("userName", "")方法来获取用户名，如果获取不到则使用空字符串作为默认值，并将结果存储在变量tt中。
    let tt = await PreferenceUtil.get("userName", "") as string
    //再次使用LogUtil.info()方法输出日志，记录获取到的用户名
    LogUtil.info('userName', tt)
  }

  startCount() {
    let timer = setInterval(async function(){//创建定时器
      if (this.stop_timer) {
        clearInterval(timer)//判断是否需要清除定时器
      }
      this.getAll()//获取用户偏好设置
      LogUtil.info('setTimeout  do after 1s delay.');//1秒延迟后执行输出日志
      let res1 = await loginApi.loadData1()//使用loginApi异步方法获取数据
      let res2 = await loginApi.loadData2()//使用loginApi异步方法获取数据
      // let res = await this.getShadowData()
      // LogUtil.info('获取数据:', JSON.stringify(res));
      let light1 = JSON.parse(res1.result).shadow[0].reported.properties.light1
      let light2 = JSON.parse(res2.result).shadow[0].reported.properties.light2
      LogUtil.info('light1', light1)
      LogUtil.info('light2', light2)

      // 前两位数代表红绿灯，后4位代表时间
      // 1，2，3代表红黄绿灯
      // 130401就代表 红灯:04  绿灯:01
      let dengs = ["red light","yellow light","green light"];
      let dengImgs = [$r("app.media.hong"),$r("app.media.huang"),$r("app.media.lv")];
      // light1
      light1=light1+"";
      this.deng=parseInt(light1[0])
      this.dengStr=dengs[this.deng-1]
      this.dengImg=dengImgs[this.deng-1]
      this.time=light1.substring(2,4)

      this.deng2=parseInt(light1[1])
      this.dengStr2=dengs[this.deng2-1]
      this.dengImg2=dengImgs[this.deng2-1]
      this.time2=light1.substring(4)

      light2=light2+"";
      this.deng3=parseInt(light2[0])
      this.dengStr3=dengs[this.deng3-1]
      this.dengImg3=dengImgs[this.deng3-1]
      this.time3=light2.substring(2,4)

      this.deng4=parseInt(light2[1])
      this.dengStr4=dengs[this.deng4-1]
      this.dengImg4=dengImgs[this.deng4-1]
      this.time4=light2.substring(4)
      // if (res.Status == 0) {//根据获取的数据进行处理，例如根据不同的ApiTag值设置相应的灯的状态、时间、车牌号等信息
      //   res.ResultObj.forEach(item => {
      //     if (item.ApiTag == "deng") {
      //       this.deng = item.Value
      //       if(this.deng==1){
      //         this.dengStr="红灯"
      //         this.dengImg=$r("app.media.hong")
      //       }else if(this.deng==2){
      //         this.dengStr="黄灯"
      //         this.dengImg=$r("app.media.huang")
      //       }else if(this.deng==3){
      //         this.dengStr="绿灯"
      //         this.dengImg=$r("app.media.lv")
      //       }
      //     }
      //     if (item.ApiTag == "deng2") {
      //       this.deng2 = item.Value
      //       if(this.deng2==1){
      //         this.dengStr2="红灯"
      //         this.dengImg2=$r("app.media.hong")
      //       }else if(this.deng2==2){
      //         this.dengStr2="黄灯"
      //         this.dengImg2=$r("app.media.huang")
      //       }else if(this.deng2==3){
      //         this.dengStr2="绿灯"
      //         this.dengImg2=$r("app.media.lv")
      //       }
      //     }
      //
      //
      //     if (item.ApiTag == "time") {
      //       this.time = item.Value
      //     }
      //     if (item.ApiTag == "time2") {
      //       this.time2 = item.Value
      //     }
      //     if (item.ApiTag == "carNumber") {
      //       this.carNumber = item.Value
      //     }
      //     if (item.ApiTag == "carNumber2") {
      //       this.carNumber2 = item.Value
      //     }
      //
      //     if (item.ApiTag == "level") {
      //       this.level = item.Value
      //     }
      //
      //     if (item.ApiTag == "level2") {
      //       this.level2 = item.Value
      //     }
      //   })
      // }


      try {//对计数器进行递增操作，出现异常则记录日志
        this.cot = this.cot + 1;
      } catch (e) {
        LogUtil.info('setTimeout  do after 1s delay.' + e);
      }
      //此处实现倒计时效果
    }.bind(this), 100)//使用bind来确保函数内部可以访问到外部的this对象
  }

  @Builder
  tabBar(text: string | Resource, index: number, img: Resource, selectImg: Resource) {
    Column({ space: 5 }) {
      if (this.selectIndex === index) {
        Image(selectImg).width(30).height(30)
        Text(text).fontSize(20).fontColor("#E02E24")
      } else {
        Image(img).width(30).height(30)
        Text(text).fontSize(20).fontColor("#656565")
      }
    }.onClick(() => {
      this.control.changeIndex(index)
    })
  }//这段代码用于生成一个选项卡组件，根据传入的参数来显示不同状态下的标签样式，并在用户点击标签时执行相应的操作。

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this .control, index: this.selectIndex }) {


      TabContent() {
        Column() {
          Row() {
            Text("Multi-intersection traffic light status display").textAlign(TextAlign.Center).fontSize(40).margin({ top: 10 }).fontColor("#ff5478cb").fontWeight(700)
          }.width("100%").justifyContent(FlexAlign.Center).borderWidth(1)
          Row(){
            Column(){
              Row() {
                Column() {
                  Image(this.dengImg).width(100)
                  Text(this.dengStr).fontColor("#ff5478cb").fontSize(20)
                }
                Text(this.time+"").margin({ left: 95 }).fontColor("#ff000309").fontWeight(500).fontSize(45)
              }.width("85%")
              Divider().margin(1)
              Row() {
                Column() {
                  Image(this.dengImg2).width(100)
                  Text(this.dengStr2).fontColor("#ff5478cb").fontSize(20)
                }
                Text(this.time2+"").margin({ left: 95 }).fontColor("#ff160601").fontWeight(500).fontSize(45)
              }.width("85%")
              Divider().margin(1).color(Color.Red)
            }
          }.margin({top: 50, bottom: 50})

          Row(){
            Column(){
              Row() {
                Column() {
                  Image(this.dengImg3).width(100)
                  Text(this.dengStr3).fontColor("#ff5478cb").fontSize(20)
                }
                Text(this.time3+"").margin({ left: 95 }).fontColor("#ff000309").fontWeight(500).fontSize(45)
              }.width("85%")
              Divider().margin(1)
              Row() {
                Column() {
                  Image(this.dengImg4).width(100)
                  Text(this.dengStr4).fontColor("#ff5478cb").fontSize(20)
                }
                Text(this.time4+"").margin({ left: 95 }).fontColor("#ff160601").fontWeight(500).fontSize(45)
              }.width("85%")
              Divider().margin(1).color(Color.Red)
            }
          }.margin({top: 50, bottom: 50})





          // Row(){
          //   Text("路口一预测:"+this.level+"").margin({ left: 50 }).fontColor("#ff160601").fontWeight(500).fontSize(45).width("85%").height("10%")
          //
          // }
          // Divider().margin(1).color(Color.Red)
          // Row(){
          //   Text("路口二预测:"+this.level2+"").margin({ left: 50 }).fontColor("#ff160601").fontWeight(500).fontSize(45).width("85%").height("10%")
          //
          // }
          // Divider().margin(1).color(Color.Red)

        }.width("100%").height("100%").justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Center)
      }
      //这段代码用于构建一个包含红绿灯状态显示和相关信息的UI界面，通过Tabs和TabContent组件实现不同标签内容的展示

      .width("100%")
      .width("100%")
      .backgroundColor("#fff")
      .tabBar(this.tabBar($r("app.string.tab_cont"), 0, $r("app.media.yan1"), $r("app.media.yan2")))
      .width("100%")
      .height("100%")




      TabContent() {
        Column() {
          Image($r("app.media.jinxing")).width(300).margin({ bottom: 70, top: 100 })

          Button("Prohibition lu").width(170).margin({ top: 30 }).onClick(async ()=>{

            let cmdParam = {
              "service_id" : "traffic_light1",
              "command_name" : "lu1_ban",
              "paras" : {
                "lu1" : "1"
              }
            }
            // let res=await loginApi.banLu1(cmdParam);
            let res= loginApi.banLu1(cmdParam);

            promptAction.showToast({//点击按钮时，会异步调用loginApi.sendCmd方法发送指令"930047"和参数"lu"，并等待返回结果。
              // 如果返回结果的Status为0，则通过
              message: "lu ban successful"
            })

            // let resLu1=await loginApi.sendCmd("lu","930047")
            // if(resLu1.Status==0){
            //   promptAction.showToast({//点击按钮时，会异步调用loginApi.sendCmd方法发送指令"930047"和参数"lu"，并等待返回结果。
            //     // 如果返回结果的Status为0，则通过
            //     message: "lu禁行成功"
            //   })
            // }
          })
          Button("Prohibition lu2").width(170).margin({ top: 30 }).onClick(async ()=>{
            let cmdParam = {
              "service_id" : "traffic_light1",
              "command_name" : "lu2_ban",
              "paras" : {
                "lu2" : "1"
              }
            }
            // let res=await loginApi.banLu1(cmdParam);
            let res=loginApi.banLu2(cmdParam);

            promptAction.showToast({//点击按钮时，会异步调用loginApi.sendCmd方法发送指令"930047"和参数"lu"，并等待返回结果。
              // 如果返回结果的Status为0，则通过
              message: "lu2 ban successful"
            })

            // promptAction.showToast({//点击按钮时，会异步调用loginApi.sendCmd方法发送指令"930047"和参数"lu2"，并等待返回结果。
            //   // 如果返回结果的Status为0，则通过
            //   message: "1111"
            // })
            // let resLu2=await loginApi.sendCmd("lu2","930047")
            // promptAction.showToast({//点击按钮时，会异步调用loginApi.sendCmd方法发送指令"930047"和参数"lu2"，并等待返回结果。
            //   // 如果返回结果的Status为0，则通过
            //   message: resLu2.Status
            // })
            // if(resLu2.Status==0){
            //   promptAction.showToast({//点击按钮时，会异步调用loginApi.sendCmd方法发送指令"930047"和参数"lu2"，并等待返回结果。
            //     // 如果返回结果的Status为0，则通过
            //     message: "lu2禁行成功"
            //   })
            // }
          })


        }
      }
      .backgroundColor("#" +
      "fff")
      .tabBar(this.tabBar($r("app.string.tab_mobile"), 1, $r("app.media.che1"), $r("app.media.che2")))
    } //  end Tabs
    .onChange((index) => {
      this.selectIndex = index
    })//这段代码实现了一个包含图片和按钮的TabContent组件，按钮点击后会发送指令并根据返回结果显示提示消息。
    // 另外，通过onChange事件处理程序来更新当前选中的索引值
  }
}