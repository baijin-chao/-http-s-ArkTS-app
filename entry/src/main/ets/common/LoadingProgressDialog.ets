@CustomDialog
export struct LoadingProgressDialog {
  controller: CustomDialogController = new CustomDialogController({ builder: '' });
//初始化为一个新的 CustomDialogController 实例，其中传入了一个包含 builder 字段的对象，但该对象的值为空字符串
  build() {
    Column() {
      LoadingProgress()//用户等待数据加载或处理过程中显示一个视觉指示
        .width(80)
        .height(80)
        .color("#FF0000");
      Text("加载中...")
        .margin({ top: $r('app.float.vp_ten'), bottom: $r('app.float.vp_ten') });
    }
    .width(140)
    .height(160)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .borderRadius($r('app.float.vp_ten'))
    .backgroundColor($r('app.color.white'))
  }
}