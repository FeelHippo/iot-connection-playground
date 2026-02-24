import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:giggle/presentation/common/app_scaffold.dart';
import 'package:giggle/presentation/home/screen.dart';
import 'package:giggle/presentation/themes/theme.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: AppTheme.lightTheme(),
      home: const AppScaffold(body: HomeScreen()),
      locale: const Locale('en'),
    );
  }
}
