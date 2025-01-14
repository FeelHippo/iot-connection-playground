import 'package:flutter/material.dart';
import 'package:giggle/presentation/navigation/app_navigator.dart';
import 'package:giggle/presentation/navigation/app_routes.dart';
import 'package:giggle/presentation/navigation/widgets/custom_route.dart';
import 'package:giggle/presentation/onboarding/carousel/carousel_widget.dart';
import 'package:giggle/presentation/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

abstract class OnBoardingRoutes {
  static AppRoute<dynamic> carouselScreen() => AppRoute<dynamic>(
        'carousel_screen',
        routeBuilder: (BuildContext context, AppNavigator appNavigator) {
          return CustomRoute<String>(
            appNavigator: appNavigator,
            builder: (_) => Provider<AppNavigator>.value(
              value: appNavigator,
              child: AppScaffold(
                body: CarouselWidget(),
              ),
            ),
          );
        },
      );
}
