import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_scaffold.dart';
import '../dependencies/injector.dart';
import 'widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Consumer<IOC>(
        builder: (BuildContext context, IOC ioc, Widget? child) {
          return RegistrationWidget();
        },
      ),
    );
  }
}
