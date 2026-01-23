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

  final IOC scope;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Creates a value, store it, and expose it to its descendants
    return Provider<IOC>(
      key: key,
      create: (BuildContext context) => scope,
      dispose: (BuildContext context, IOC scope) => scope.dispose(),
      child: child,
    );
  }
}
