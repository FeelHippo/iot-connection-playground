import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giggle/presentation/common/scope_consumer_widget.dart';
import 'package:giggle/presentation/common/scope_provider_widget.dart';
import 'package:giggle/presentation/dependencies/injector.dart';
import 'package:giggle/utils/dashboard_controller.dart';

import 'bloc/simple_bloc_observer.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    DashboardController.preserve();

    await setUp();

    final IOC ioc = IOC.appScope();

    runApp(
      EasyLocalization(
        supportedLocales: <Locale>[
          Locale('en'),
          Locale('de'),
          Locale('fr'),
          Locale('it'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GiggleApp(scope: ioc),
      ),
    );

    Bloc.observer = SimpleBlocDelegate();
    DashboardController.remove();
  }, (Object error, StackTrace stackTrace) => Fimber.e('$error, $stackTrace'));
}

Future<void> setUp() async {
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env', mergeWith: Platform.environment);
}

class GiggleApp extends StatelessWidget {
  const GiggleApp({super.key, required this.scope});
  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return ScopeProviderWidget(scope: scope, child: ScopeConsumerWidget());
  }
}
