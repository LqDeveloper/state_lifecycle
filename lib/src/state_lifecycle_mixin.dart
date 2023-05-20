import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'lifecycle_route_observer.dart';
import 'context_scroll_extension.dart';

mixin StateLifecycleMixin<T extends StatefulWidget> on State<T>
    implements WidgetsBindingObserver, RouteAware {
  bool _didRunOnContextReady = false;
  ModalRoute? _modalRoute;

  ///当前路由的名称
  String? get routeName => _modalRoute?.settings.name;

  ///当前路由的参数
  Object? get arguments => _modalRoute?.settings.arguments;

  ///是否位于PageView中
  bool _isInPageView = false;

  ///页面位于PageView中的索引
  int get pageIndex => -1;

  ///PageView所在页面的索引
  int _currentIndex = -1;

  bool _hasAppear = false;

  ///监听滚动事件
  ScrollNotificationObserverState? _scrollState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onPostFrame();
      _initPageViewState();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didRunOnContextReady) {
      _didRunOnContextReady = true;
      onContextReady();
    }

    ///首次调用时添加路由监听，监听 RouteAware 生命周期
    if (_modalRoute == null) {
      _modalRoute = ModalRoute.of(context);
      if (_modalRoute == null) return;
      LifecycleRouteObserver.subscribe(this, _modalRoute!);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    LifecycleRouteObserver.unsubscribe(this);
    _disposeScrollState();
    _modalRoute = null;
    onDispose();
    super.dispose();
  }

  ///******************************位于PageView中的处理***************************************
  ///初始化滚动信息
  void _initPageViewState() {
    //在父类中查找Viewport
    final renderSliver = context.findAncestorRenderObj<RenderSliver>();
    //如果距离最近的RenderSliver不是RenderSliverFillViewport类型的话，就不会去添加滚动监听
    if (renderSliver is! RenderSliverFillViewport) {
      _notifyViewAppear();
      return;
    }
    _isInPageView = true;
    assert(pageIndex > -1, '在PageView的子页面中必须设置pageIndex');

    ///添加滚动监听
    _scrollState = ScrollNotificationObserver.maybeOf(context);
    _scrollState?.addListener(_scrollNotification);
  }

  void _scrollNotification(ScrollNotification notification) {
    //ScrollNotification冒泡通过的Viewport的个数必须为0,才会去响应
    if (notification.depth > 0) return;
    if (notification is ScrollUpdateNotification) {
      _handlePageView(notification: notification);
    }
  }

  ///处理PageView的切换
  void _handlePageView({required ScrollNotification notification}) {
    if (!_isInPageView) return;
    if (notification.metrics is! PageMetrics) return;
    final PageMetrics metrics = notification.metrics as PageMetrics;
    final int index = metrics.page!.round();
    if (index != _currentIndex) {
      if (index == pageIndex) {
        //加入事件循环，似的先调用onDisappear,后调用onAppear
        Future.delayed(Duration.zero, () {
          _notifyViewAppear();
        });
      } else {
        _notifyViewDisAppear();
      }
      _currentIndex = index;
    }
  }

  ///移除滚动监听
  void _disposeScrollState() {
    _scrollState?.removeListener(_scrollNotification);
    _scrollState = null;
  }

  void _checkNotifyViewAppear() {
    if (_isInPageView) {
      if (_currentIndex != pageIndex) {
        return;
      }
      _notifyViewAppear();
    } else {
      _notifyViewAppear();
    }
  }

  void _checkNotifyViewDisAppear() {
    if (_isInPageView) {
      if (_currentIndex != pageIndex) {
        return;
      }
      _notifyViewDisAppear();
    } else {
      _notifyViewDisAppear();
    }
  }

  void _notifyViewAppear() {
    if (_hasAppear) return;
    _hasAppear = true;
    onAppear();
  }

  void _notifyViewDisAppear() {
    if (!_hasAppear) return;
    _hasAppear = false;
    onDisappear();
  }

  /// ****************************State的生命周期****************************

  ///对应State 中的initState
  void onInit() {}

  ///此阶段Context已经准备就绪，可以通过context去获取值,之后会去Build调用方法
  void onContextReady() {}

  ///对应了WidgetsBinding.instance.addPostFrameCallback
  void onPostFrame() {}

  ///路由切换，或者PageView切换，后页面展示
  void onAppear() {}

  ///路由切换，或者PageView切换，后页面不展示
  void onDisappear() {}

  ///页面即将销毁
  void onDispose() {}

  ///App从后台进入前台
  void onResume() {}

  ///App从前台进入后台
  void onPause() {}

  ///*********************RouteAware*************************
  /// (当前页面)didPushNext -> (新页面)didPush -> (新页面)didPopNext -> (当前页面)didPop
  @override
  void didPushNext() {
    _checkNotifyViewDisAppear();
  }

  @override
  void didPush() {}

  @override
  void didPopNext() {
    _checkNotifyViewAppear();
  }

  @override
  void didPop() {
    _checkNotifyViewDisAppear();
  }

  ///*********************WidgetsBindingObserver*************************
  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
      default:
        break;
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() => Future<bool>.value(false);

  @override
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return didPushRoute(routeInformation.location!);
  }
}
