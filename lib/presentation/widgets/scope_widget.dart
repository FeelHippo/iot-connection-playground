import 'package:flutter/material.dart';
import 'package:go_active/injector.dart';
import 'package:provider/provider.dart';

class ScopeWidget extends StatelessWidget {
  const ScopeWidget({super.key, required this.child, required this.scope});

  final Widget child;
  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return Provider<IOC>(
      key: key,
      create: (BuildContext context) => scope,
      dispose: (BuildContext context, IOC value) => value.dispose(),
      child: child,
    );
  }
}
