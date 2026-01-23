import 'package:flutter/material.dart';
import 'package:giggle/presentation/onboarding/intro/widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/app_scaffold.dart';
import '../../dependencies/injector.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<dynamic>.delayed(
      const Duration(seconds: 1),
    ).then((_) => context.go('/register'));
    return AppScaffold(
      body: Consumer<IOC>(
        builder: (BuildContext context, IOC ioc, Widget? child) {
          return const IntroWidget();
        },
      ),
    );
  }
}
