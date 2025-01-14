import 'package:flutter/material.dart';
import 'package:giggle/presentation/navigation/app_navigator.dart';
import 'package:provider/provider.dart';

class CustomRoute<T> extends PopupRoute<T> {
  CustomRoute(
      {required this.builder, this.appNavigator, this.isProvider = true});

  final WidgetBuilder builder;
  final AppNavigator? appNavigator;
  final bool? isProvider;

  @override
  Color? get barrierColor => null;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  AnimationController createAnimationController() {
    return AnimationController(
      duration: transitionDuration,
      debugLabel: 'CustomPopupRoute',
      vsync: navigator!.overlay!,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    DragStartDetails startHorizontalDragDetails = DragStartDetails();
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails dragDetails) {
        startHorizontalDragDetails = dragDetails;
      },
      onHorizontalDragEnd: (DragEndDetails drag) {
        if (drag.primaryVelocity == null) return;
        if (drag.primaryVelocity! > 0 &&
            startHorizontalDragDetails.globalPosition.dx.floorToDouble() <
                50.0) {
          Navigator.pop(context);
        }
      },
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.8, 0.0), // adjust the position as you need
          end: Offset.zero,
        ).animate(animation),
        child: isProvider!
            ? Provider<AppNavigator>.value(
                value: appNavigator!,
                child: child,
              )
            : child,
      ),
    );
  }
}
