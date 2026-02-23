import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:giggle/presentation/common/app_scaffold.dart';
import 'package:giggle/presentation/common/circular_progress_bar.dart';
import 'package:giggle/presentation/home/screen.dart';
import 'package:giggle/presentation/profile/screen.dart';
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
              BuildContext context,
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
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: context.tr('home'),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: context.tr('profile'),
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
