import 'package:flutter/material.dart';
import 'package:giggle/presentation/navigation/app_navigator.dart';
import 'package:giggle/presentation/navigation/app_routes.dart';
import 'package:giggle/presentation/navigation/widgets/custom_route.dart';
import 'package:giggle/presentation/onboarding/locales/locales_widget.dart';
import 'package:giggle/presentation/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

abstract class OnBoardingRoutes {
  static AppRoute<dynamic> localesScreen() => AppRoute<dynamic>(
        'locales_screen',
        routeBuilder: (BuildContext context, AppNavigator appNavigator) {
          return CustomRoute<String>(
            appNavigator: appNavigator,
            builder: (_) => Provider<AppNavigator>.value(
              value: appNavigator,
              child: AppScaffold(
                body: LocalesWidget(),
              ),
            ),
          );
        },
      );
  static AppRoute<dynamic> termsAndConditionsScreen() => AppRoute<dynamic>(
        'terms_and_conditions_screen',
        routeBuilder: (BuildContext context, AppNavigator appNavigator) {
          return CustomRoute<String>(
            appNavigator: appNavigator,
            builder: (_) => Provider<AppNavigator>.value(
              value: appNavigator,
              child: AppScaffold(
                body: Container(), // TODO(Filippo): continue from here
              ),
            ),
          );
        },
      );
}
