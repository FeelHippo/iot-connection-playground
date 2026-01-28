import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BlueToothPlusWidget extends StatefulWidget {
  const BlueToothPlusWidget({super.key});

  @override
  State<BlueToothPlusWidget> createState() => _BlueToothPlusWidgetState();
}

class _BlueToothPlusWidgetState extends State<BlueToothPlusWidget> {
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    // https://api.flutter.dev/flutter/widgets/AppLifecycleListener-class.html
    AppLifecycleListener(
      onShow: () async {
        if (await FlutterBluePlus.isSupported == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: const Text(
                'Bluetooth not supported by this device',
                textAlign: TextAlign.center,
              ),
            ),
          );
          return;
        }
        _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((
          BluetoothAdapterState state,
        ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: Text(state.name, textAlign: TextAlign.center),
            ),
          );
        });
        if (Platform.isAndroid) {
          await FlutterBluePlus.turnOn();
        }
      },
      onExitRequested: () async {
        await _adapterStateStateSubscription.cancel();
        return AppExitResponse.exit;
      },
    );
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          child: const Text(
            'Bluetooth Low Energy plugin',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () => launchUrl(
            Uri.parse('https://pub.dev/packages/flutter_blue_plus'),
          ),
        ),
        FloatingActionButton(
          key: const Key('mqtt_client_aws_iot_core'),
          heroTag: 'mqtt_client_aws_iot_core',
          onPressed: _connectToBlueTooth,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Future<void> _connectToBlueTooth() async {
    // listen to scan results
    final StreamSubscription<List<ScanResult>>
    subscription = FlutterBluePlus.onScanResults.listen((
      List<ScanResult> results,
    ) {
      if (results.isNotEmpty) {
        final ScanResult r = results.last;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            content: Text(
              '${r.device.remoteId}: "${r.advertisementData.advName}" found!',
              textAlign: TextAlign.center,
            ),
          ),
        );
        final BluetoothDevice device = r.device;
        // listen for disconnection
        final StreamSubscription<BluetoothConnectionState>
        subscription = device.connectionState.listen((
          BluetoothConnectionState state,
        ) async {
          if (state == BluetoothConnectionState.disconnected) {
            // 1. typically, start a periodic timer that tries to
            //    reconnect, or just call connect() again right now
            // 2. you must always re-discover services after disconnection!
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(
                  '${device.disconnectReason?.code} ${device.disconnectReason?.description}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        });

        // cleanup: cancel subscription when disconnected
        //   - [delayed] This option is only meant for `connectionState` subscriptions.
        //     When `true`, we cancel after a small delay. This ensures the `connectionState`
        //     listener receives the `disconnected` event.
        //   - [next] if true, the the stream will be canceled only on the *next* disconnection,
        //     not the current disconnection. This is useful if you setup your subscriptions
        //     before you connect.
        device.cancelWhenDisconnected(subscription, delayed: true, next: true);

        // Connect to the device
        await device.connect();
      }
    }, onError: print);
    // cleanup: cancel subscription when scanning stops
    FlutterBluePlus.cancelWhenScanComplete(subscription);
    // Start scanning w/ timeout
    await FlutterBluePlus.startScan(
      withServices: <Guid>[Guid('180D')],
      withNames: <String>['Bluno'],
      timeout: const Duration(seconds: 15),
    );
    // wait for scanning to stop
    await FlutterBluePlus.isScanning.where((bool val) => val == false).first;
  }
}
