import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giggle/injector.dart';
import 'package:giggle/presentation/onboarding/locales/cubit.dart';
import 'package:giggle/presentation/splash/splash_screen.dart';
import 'package:giggle/presentation/themes/theme.dart';
import 'package:giggle/presentation/widgets/scope_widget.dart';
import 'package:giggle/utils/dashboard_controller.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await setUp();

      DashboardController.preserve();

      final IOC ioc = IOC.appScope();

      runApp(
        EasyLocalization(
          supportedLocales: [
            Locale('en'),
            Locale('de'),
            Locale('fr'),
            Locale('it'),
          ],
          path: 'assets/translations',
          fallbackLocale: Locale('en'),
          child: GiggleApp(scope: ioc),
          startLocale: ioc.getDependency<LocaleCubit>().state,
        ),
      );

      Bloc.observer = SimpleBlocDelegate();
      DashboardController.remove();
    },
    (Object error, StackTrace stackTrace) => Fimber.e('$error, $stackTrace'),
  );
}

Future<void> setUp() async {
  await EasyLocalization.ensureInitialized();
  await dotenv.load(
    fileName: '.env',
    mergeWith: Platform.environment,
  );
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}

class GiggleApp extends StatelessWidget {
  const GiggleApp({
    super.key,
    required this.scope,
  });
  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return ScopeWidget(
      scope: scope,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.lightTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
