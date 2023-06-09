///State 的生命周期
enum LifecycleState {
  /// 对应 state 的initState
  onInit,

  ///此状态在 [initState] 之后调用。
  ///在此状态使用BuildContext是安全的
  onContextReady,

  ///当前Frame绘制完后进行回调
  ///WidgetsBinding.instance.addPostFrameCallback
  onPostFrame,

  ///页面显示
  onAppear,

  ///页面不显示
  onDisappear,

  ///页面销毁
  onDispose,

  ///App从后台进入前台
  onResume,

  ///App从前台进入后台
  onPause;
}
