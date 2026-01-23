import 'package:flutter/material.dart';
import 'package:giggle/presentation/common/app_scaffold.dart';
import 'package:giggle/presentation/common/circular_progress_bar.dart';
import 'package:giggle/presentation/home/screen.dart';
import 'package:giggle/presentation/login/screen.dart';
import 'package:giggle/presentation/onboarding/intro/screen.dart';
import 'package:giggle/presentation/profile/screen.dart';
import 'package:giggle/presentation/registration/screen.dart';
import 'package:go_router/go_router.dart';

final ValueNotifier<RoutingConfig> routingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, __) =>
            const AppScaffold(body: Center(child: CircularProgressBar())),
      ),
    ],
  ),
);

final GoRouter router = GoRouter.routingConfig(
  routingConfig: routingConfig,
  initialLocation: '/',
);

final RoutingConfig unauthorizedRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (_, __) => const IntroScreen()),
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

RoutingConfig authorizedRoutingConfig({Color? selectedItemColor}) {
  // https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
  final GlobalKey<NavigatorState> shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'home');
  final GlobalKey<NavigatorState> shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile');
  return RoutingConfig(
    redirect: (BuildContext context, GoRouterState state) {
      if (state.fullPath?.isEmpty ?? false) {
        return '/home';
      }
    },
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder:
            (
              Object? context,
              GoRouterState state,
              StatefulNavigationShell navShell,
            ) => AppScaffold(
              body: navShell,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navShell.currentIndex,
                onTap: (int index) => navShell.goBranch(
                  index,
                  initialLocation: index == navShell.currentIndex,
                ),
                selectedItemColor: selectedItemColor,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: shellNavigatorHomeKey,
            routes: <RouteBase>[
              GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorProfileKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/profile',
                builder: (_, __) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'profile/update',
                    builder: (BuildContext context, GoRouterState state) =>
                        const Text('User Profile Update Here'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
