import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:giggle/presentation/router/go_router.dart';
import 'package:giggle/presentation/themes/theme.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: AppTheme.lightTheme(),
      routerConfig: router,
      locale: const Locale('en'),
    );
  }
}
