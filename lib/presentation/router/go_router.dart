import 'package:flutter/material.dart';
import 'package:giggle/presentation/common/app_scaffold.dart';
import 'package:giggle/presentation/common/circular_progress_bar.dart';
import 'package:giggle/presentation/onboarding/intro/screen.dart';
import 'package:giggle/presentation/onboarding/locales/screen.dart';
import 'package:go_router/go_router.dart';

import '../home/screen.dart';
import '../login/screen.dart';
import '../registration/screen.dart';

final GoRouter router = GoRouter.routingConfig(
  routingConfig: routingConfig,
  initialLocation: '/',
);

final ValueNotifier<RoutingConfig> routingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, __) =>
            AppScaffold(body: Center(child: CircularProgressBar())),
      ),
    ],
  ),
);

final RoutingConfig unauthorizedRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (_, __) => const IntroScreen()),
    GoRoute(
      path: '/locales',
      builder: (BuildContext context, GoRouterState state) {
        return const LocalesScreen();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegistrationScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);

final RoutingConfig authorizedRoutingConfig = RoutingConfig(
  redirect: (BuildContext context, GoRouterState state) {
    // this is a workaround. When coming from unauthorizedRoutingConfig.register
    // the context is not updated, and keeps '/register' as the current route
    // which is not a valid authorizedRoutingConfig route, causing an error
    if (state.matchedLocation.contains('register')) {
      return '/';
    } else {
      return null;
    }
  },
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
  ],
);
