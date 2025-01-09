import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CustomNavigator extends StatefulWidget {
  const CustomNavigator(
      {Key? key, this.navigatorKey, required this.onGenerateRoute})
      : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  final RouteFactory onGenerateRoute;

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator>
    with WidgetsBindingObserver {
  late GlobalKey<NavigatorState> _navigatorKey;
  late CurrentRouteNotifier _routeNotifier;

  @override
  void initState() {
    super.initState();
    _navigatorKey = widget.navigatorKey ?? GlobalKey();
    _routeNotifier = CurrentRouteNotifier();
    WidgetsBinding.instance.addObserver(this);
  }

  // A system method that get invoked when user press back button on Android or back slide on iOS
  @override
  Future<bool> didPopRoute() async {
    assert(mounted);
    final NavigatorState? navigator = _navigatorKey.currentState;
    if (navigator == null) {
      return false;
    }
    return navigator.maybePop();
  }

  @override
  Future<bool> didPushRoute(String route) async {
    assert(mounted);
    final NavigatorState? navigator = _navigatorKey.currentState;
    if (navigator == null) return false;
    await navigator.pushNamed(route);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableProvider<ChangeRouteEvent?>.value(
      value: _routeNotifier,
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: widget.onGenerateRoute,
        observers: <NavigatorObserver>[
          AppNavigatorObserver(_routeNotifier),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class AppNavigatorObserver extends NavigatorObserver {
  AppNavigatorObserver(this._routeNotifier);

  final CurrentRouteNotifier _routeNotifier;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _routeNotifier.value =
          ChangeRouteEvent(route, previousRoute, ChangeRouteEventType.push);
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _routeNotifier.value =
          ChangeRouteEvent(previousRoute, route, ChangeRouteEventType.pop);
    });
  }
}

class CurrentRouteNotifier extends ValueNotifier<ChangeRouteEvent?> {
  CurrentRouteNotifier() : super(null);
}

class ChangeRouteEvent {
  ChangeRouteEvent(this.currentRoute, this.previousRoute, this.type);

  final Route<dynamic>? currentRoute;
  final Route<dynamic>? previousRoute;
  final ChangeRouteEventType type;
}

enum ChangeRouteEventType {
  push,
  pop,
}
