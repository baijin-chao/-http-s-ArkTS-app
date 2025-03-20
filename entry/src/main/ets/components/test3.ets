import router from '@ohos.router';
@Component
export default struct test23{
  build(){
    Column(){
      Column(){
        Image($r("app.media.666"))
      }
      .height("100%")
      Column(){
       // Image($r("app.media.logo2")).height(100)
      }.margin({bottom:40})
    }.width("100%").height("100%")
    .onClick(()=>{
      router.pushUrl({url:"pages/LoginPage"})//添加了一个点击事件处理程序，当该UI元素被点击时，会调用router.pushUrl方法跳转到"pages/LoginPage"页面
    })
  }
}//这段代码实现了一个包含两个图片的UI界面，点击该界面会跳转到登录页面




