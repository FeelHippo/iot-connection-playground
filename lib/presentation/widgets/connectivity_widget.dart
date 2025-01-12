import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_active/presentation/widgets/app_scaffold.dart';

class ConnectivityContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      // Constructs a singleton instance of Connectivity
      connectivity: Connectivity(),
    );
  }
}

class ConnectivityWidget extends StatefulWidget {
  const ConnectivityWidget({super.key, required this.connectivity});

  static const ValueKey<String> offlineLabelKey =
      ValueKey<String>('ConnectivityWidget-offline-label');

  final Connectivity connectivity;

  @override
  ConnectivityWidgetState createState() => ConnectivityWidgetState();
}

@visibleForTesting
class ConnectivityWidgetState extends State<ConnectivityWidget> {
  static const ValueKey<String> offlineSnackBarKey =
      ValueKey<String>('ConnectivityWidgetState.offlineSnackBar');

  StreamSubscription<ConnectivityResult>? _subscription;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  Future<void> checkConnectivity() async {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final ConnectivityResult result =
          await widget.connectivity.checkConnectivity();
      _updateSnackBarState(result);
      _subscription ??= widget.connectivity.onConnectivityChanged
          .listen(_updateSnackBarState);
    }
  }

  void _updateSnackBarState(ConnectivityResult result) {
    final bool isOffline = result == ConnectivityResult.none;
    if (isOffline) {
      AppScaffold.of(context)?.showSnackBar(
        AppSnackBar(
          key: offlineSnackBarKey,
          priority: AppSnackBar.priorityHigh,
          permanent: true,
          content: Text(
            'You are Offline. Please check your connection and try again', // TODO(Filippo): implement localisation
          ),
        ),
      );
    } else {
      AppScaffold.of(context)?.removeSnackBar(offlineSnackBarKey);
    }
  }
}
