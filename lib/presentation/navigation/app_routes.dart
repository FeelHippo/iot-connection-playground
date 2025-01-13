import 'package:flutter/material.dart';
import 'package:go_active/presentation/navigation/app_navigator.dart';
import 'package:go_active/presentation/navigation/routes/dashboard.dart';

abstract class AppRoutes {
  static AppRoute<dynamic> dashboard = AppDashboardRoutes.dashboard;
}

class AppRoute<T> {
  const AppRoute(this.name, {this.routeBuilder});

  final String name;
  final Route<T>? Function(
    BuildContext context,
    AppNavigator navigator,
  )? routeBuilder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRoute<dynamic> &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
