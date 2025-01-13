import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';

class AppNavigator {
  static String onboardingNavigationRoute = 'onboardingNavigationRoute';

  static AppNavigator of(BuildContext context) {
    return Provider.of<AppNavigator>(context, listen: false);
  }

  final GlobalKey<NavigatorState> navigatorKey;

  AppNavigator(
    this.navigatorKey,
  );

  @optionalTypeArgs
  Future<T?> push<T extends Object?>(AppRoute<T>? appRoute,
      {Object? arguments}) async {
    final BuildContext? currentContext = navigatorKey.currentContext;
    if (currentContext == null) {
      Fimber.d('navigator context is null');
      return null;
    }
    final NavigatorState? currentState = navigatorKey.currentState;
    if (currentState == null) {
      Fimber.d('navigator state is null');
      return null;
    }

    final Route<T>? route = appRoute?.routeBuilder?.call(currentContext, this);
    if (route != null) {
      return currentState.push(route);
    } else {
      Fimber.d('route is null');
    }
    return Future<T>.value();
  }

  Future<T?> pushReplacement<T extends Object?>(AppRoute<T>? appRoute) async {
    final BuildContext? currentContext = navigatorKey.currentContext;
    if (currentContext == null) {
      Fimber.d('navigator context is null');
      return null;
    }
    final NavigatorState? currentState = navigatorKey.currentState;
    if (currentState == null) {
      Fimber.d('navigator state is null');
      return null;
    }

    final Route<T>? route = appRoute?.routeBuilder?.call(currentContext, this);
    if (route != null) {
      return navigatorKey.currentState?.pushReplacement(route);
    } else {
      navigatorKey.currentState?.pop();
    }
    return Future<T>.value();
  }

  void pop([dynamic result]) {
    navigatorKey.currentState?.pop(result);
  }

  /// navigatePage
  // static Future<dynamic> navigatePage({
  //   required Widget className,
  //   required BuildContext context,
  //   bool isReplace = false,
  //   VoidCallback? onClose,
  //   bool isBottomSheet = false,
  //   bool shouldSwipeToCloseWidget = true,
  // }) async {
  //   if (isBottomSheet) {
  //     return !isReplace
  //         ? Navigator.push(
  //             context,
  //             CustomPopupRoute<Widget>(
  //                 widgetBuilder: (_) => className,
  //                 enableDragToDismiss: shouldSwipeToCloseWidget),
  //           ).then((_) {
  //             if (onClose != null) {
  //               onClose();
  //             }
  //           })
  //         : Navigator.pushReplacement(
  //             context,
  //             CustomPopupRoute<Widget>(
  //               widgetBuilder: (_) => className,
  //             ),
  //           ).then((_) {
  //             if (onClose != null) {
  //               onClose();
  //             }
  //           });
  //   } else {
  //     return !isReplace
  //         ? Navigator.push(
  //             context,
  //             CustomRoute<Widget>(
  //               isProvider: false,
  //               builder: (_) => className,
  //             ),
  //           ).then((_) {
  //             if (onClose != null) {
  //               onClose();
  //             }
  //           })
  //         : Navigator.pushReplacement(
  //             context,
  //             CustomRoute<Widget>(
  //               isProvider: false,
  //               builder: (_) => className,
  //             ),
  //           ).then((_) {
  //             if (onClose != null) {
  //               onClose();
  //             }
  //           });
  //   }
  // }

  void popUntilRoot() {
    navigatorKey.currentState
        ?.popUntil((Route<dynamic> route) => route.isFirst);
  }

  static void doPopUp(BuildContext context) {
    Navigator.pop(context);
  }
}
