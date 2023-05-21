# StateLifecycle

The flutter StateLifecycle enables Flutter to have a page lifecycle like iOS UIViewController and
Android Activity.

## Class

1. ContextScrollExtension: Extension of BuildContext.
2. LifecycleRouteObserver: Listen for routing events.
3. StateLifecycleMixin : Mixin of State.

## Lifecycle Method

```dart

///like initState in State
void onInit() {}

///In this method, the Context is ready, you can get the value through the context, and then call the build method
void onContextReady() {}

///WidgetsBinding.instance.addPostFrameCallback
void onPostFrame() {}

///Call this method when this page appear
void onAppear() {}

///all this method when this page disappear
void onDisappear() {}

///like dispose in State
void onDispose() {}

///App enters foreground from background
void onResume() {}

///App enters background from foreground
void onPause() {}
```

## Add Route observer

```dart
   MaterialApp(
      navigatorObservers: [LifecycleRouteObserver.routeObserver],
    );
```

## Normal Page

```dart
class _PageFourState extends State<PageFour> with StateLifecycleMixin {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  @override
  void onInit() {
    super.onInit();
    print("$_pageName ------ onInit");
  }

  @override
  void onContextReady() {
    super.onContextReady();
    print("$_pageName ------ onContextReady");
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    print("$_pageName ------ onPostFrame");
  }

  @override
  void onAppear() {
    super.onAppear();
    print("$_pageName ------ onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    print("$_pageName ------ onDisappear");
  }

  @override
  void onResume() {
    super.onResume();
    print("$_pageName ------ onResume");
  }

  @override
  void onPause() {
    super.onPause();
    print("$_pageName ------ onPause");
  }

  @override
  void onDispose() {
    super.onDispose();
    print("$_pageName ------ onDispose");
  }
}

```

## Page in PageView,TabBarView

Must override pageIndex,the value is the page's index in PageView

```dart
class _PageFourState extends State<PageFour> with StateLifecycleMixin {

  @override
  int get pageIndex => 0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  @override
  void onInit() {
    super.onInit();
    print("$_pageName ------ onInit");
  }

  @override
  void onContextReady() {
    super.onContextReady();
    print("$_pageName ------ onContextReady");
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    print("$_pageName ------ onPostFrame");
  }

  @override
  void onAppear() {
    super.onAppear();
    print("$_pageName ------ onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    print("$_pageName ------ onDisappear");
  }

  @override
  void onResume() {
    super.onResume();
    print("$_pageName ------ onResume");
  }

  @override
  void onPause() {
    super.onPause();
    print("$_pageName ------ onPause");
  }

  @override
  void onDispose() {
    super.onDispose();
    print("$_pageName ------ onDispose");
  }
}

```