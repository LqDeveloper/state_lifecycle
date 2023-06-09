import 'package:flutter/material.dart';
import 'package:lq_state_lifecycle/lq_state_lifecycle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [LifecycleRouteObserver.routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Lifecycle'),
      ),
      body: PageView(
        children: const [
          PageOne(),
          PageTwo(),
          PageThree(),
        ],
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne>
    with StateLifecycleMixin, AutomaticKeepAliveClientMixin {
  @override
  int get pageIndex => 0;

  final String _pageName = 'PageOne';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageName),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(CustomRouter(builder: (_) => const PageFour()));
            },
            child: const Text('点击跳转页面')),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("$_pageName ------ onInit");
  }

  @override
  void onAppear() {
    super.onAppear();
    debugPrint("$_pageName ------ onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    debugPrint("$_pageName ------ onDisappear");
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo>
    with StateLifecycleMixin, AutomaticKeepAliveClientMixin {
  @override
  int get pageIndex => 1;

  final String _pageName = 'PageTwo';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageName),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(CustomRouter(builder: (_) => const PageFour()));
            },
            child: const Text('点击跳转页面')),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("$_pageName ------ onInit");
  }

  @override
  void onAppear() {
    super.onAppear();
    debugPrint("$_pageName ------ onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    debugPrint("$_pageName ------ onDisappear");
  }
}

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree>
    with StateLifecycleMixin, AutomaticKeepAliveClientMixin {
  @override
  int get pageIndex => 2;

  final String _pageName = 'PageThree';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageName),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(CustomRouter(builder: (_) => const PageFour()));
            },
            child: const Text('点击跳转页面')),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("$_pageName ------ onInit");
  }

  @override
  void onAppear() {
    super.onAppear();
    debugPrint("$_pageName ------ onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    debugPrint("$_pageName ------ onDisappear");
  }

  @override
  void onDispose() {
    super.onDispose();
    debugPrint("$_pageName ------ onDispose");
  }
}

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> with StateLifecycleMixin {
  final String _pageName = 'PageFour';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pageName),
        ),
        body: Center(
          child: TextButton(onPressed: () {}, child: const Text('点击跳转页面')),
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("$_pageName ------ onInit");
  }

  @override
  void onContextReady() {
    super.onContextReady();
    debugPrint("$_pageName ------ onContextReady");
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    debugPrint("$_pageName ------ onPostFrame");
  }

  @override
  void onAppear() {
    super.onAppear();
    debugPrint("$_pageName ------ onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    debugPrint("$_pageName ------ onDisappear");
  }

  @override
  void onResume() {
    super.onResume();
    debugPrint("$_pageName ------ onResume");
  }

  @override
  void onPause() {
    super.onPause();
    debugPrint("$_pageName ------ onPause");
  }

  @override
  void onDispose() {
    super.onDispose();
    debugPrint("$_pageName ------ onDispose");
  }
}

class CustomRouter<T> extends MaterialPageRoute<T> {
  CustomRouter({
    required super.builder,
    super.settings,
    super.maintainState = true,
    super.fullscreenDialog,
  });

  @override
  bool get hasScopedWillPopCallback => false;
}
