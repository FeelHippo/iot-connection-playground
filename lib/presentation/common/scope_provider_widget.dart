import 'package:flutter/cupertino.dart';
import 'package:giggle/presentation/dependencies/injector.dart';
import 'package:provider/provider.dart';

/// provides all child widget nodes with registered dependencies
class ScopeProviderWidget extends StatelessWidget {
  const ScopeProviderWidget({
    super.key,
    required this.child,
    required this.scope,
  });

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
