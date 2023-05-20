import 'package:flutter/material.dart';

/// 路由观察者
/// 辅助监听 RouteAware
/// 需要在 MaterialApp 中添加
/// ```dart
///     MaterialApp(
///       navigatorObservers: [LifecycleRouteObserver.routeObserver],
///     )
/// ```
class LifecycleRouteObserver {
  LifecycleRouteObserver._();

  static final RouteObserver<ModalRoute> routeObserver =
  RouteObserver<ModalRoute>();

  static void subscribe(RouteAware routeAware, ModalRoute route) {
    routeObserver.subscribe(routeAware, route);
  }

  static void unsubscribe(RouteAware routeAware) {
    routeObserver.unsubscribe(routeAware);
  }
}