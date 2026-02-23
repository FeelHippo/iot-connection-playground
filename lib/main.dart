import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giggle/presentation/common/scope_consumer_widget.dart';
import 'package:giggle/presentation/common/scope_provider_widget.dart';
import 'package:giggle/presentation/dependencies/injector.dart';
import 'package:giggle/utils/dashboard_controller.dart';

Future<void> main() async {
  // Run the app's body in its own error zone
  await runZonedGuarded<Future<void>>(() async {
    DashboardController.preserve();

    await setUp();

    final IOC ioc = IOC.appScope();

    runApp(
      EasyLocalization(
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('de'),
          Locale('fr'),
          Locale('it'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: GiggleApp(scope: ioc),
      ),
    );
    DashboardController.remove();
  }, (Object error, StackTrace stackTrace) => Fimber.e('$error, $stackTrace'));
}

Future<void> setUp() async {
  await EasyLocalization.ensureInitialized();
  await dotenv.load(mergeWith: Platform.environment);
  await FlutterBluePlus.setLogLevel(LogLevel.verbose);
}

class GiggleApp extends StatelessWidget {
  const GiggleApp({super.key, required this.scope});

  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return ScopeProviderWidget(
      scope: scope,
      child: const ScopeConsumerWidget(),
    );
  }
}
