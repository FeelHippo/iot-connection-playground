import 'dart:io';
import 'dart:typed_data';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlueToothClassicWidget extends StatefulWidget {
  const BlueToothClassicWidget({super.key});

  @override
  State<BlueToothClassicWidget> createState() =>
      _BlueToothClassicWidgetWidgetState();
}

class _BlueToothClassicWidgetWidgetState extends State<BlueToothClassicWidget> {
  late BluetoothClassic _bluetoothClassicPlugin;
  List<Device> _discoveredDevices = <Device>[];
  late DeviceInfoPlugin _deviceInfo;
  late String _deviceUid;

  @override
  void initState() {
    super.initState();
    _bluetoothClassicPlugin = BluetoothClassic();
    _deviceInfo = DeviceInfoPlugin();
    _initBluetoothClassic();
    _initDeviceUid();
    _bluetoothClassicPlugin.onDeviceStatusChanged().listen((int event) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(
            'Bluetooth device status changed: $event',
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
    _bluetoothClassicPlugin.onDeviceDataReceived().listen((Uint8List event) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(
            'Bluetooth data received: $event',
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _bluetoothClassicPlugin.disconnect();
    super.dispose();
  }

  Future<void> _initBluetoothClassic() async {
    await _bluetoothClassicPlugin.initPermissions();
    _discoveredDevices = <Device>[
      ..._discoveredDevices,
      ...await _bluetoothClassicPlugin.getPairedDevices(),
    ];
  }

  Future<void> _initDeviceUid() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      _deviceUid = androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      _deviceUid = iosInfo.identifierForVendor!;
    } else if (Platform.isLinux) {
      final LinuxDeviceInfo linuxInfo = await _deviceInfo.linuxInfo;
      _deviceUid = linuxInfo.machineId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          child: const Text(
            'Bluetooth Classic',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () => launchUrl(
            Uri.parse('https://pub.dev/packages/bluetooth_classic'),
          ),
        ),
        FloatingActionButton(
          mini: true,
          key: const Key('blue_tooth_classic'),
          heroTag: 'blue_tooth_classic',
          onPressed: _connectToBlueTooth,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Future<void> _connectToBlueTooth() async {
    await _bluetoothClassicPlugin.startScan();
    _bluetoothClassicPlugin.onDeviceDiscovered().listen((Device event) async {
      // TODO(Filippo): UI to list all available devices
      _discoveredDevices = <Device>[..._discoveredDevices, event];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const Text(
            'Bluetooth discovered some devices',
            textAlign: TextAlign.center,
          ),
        ),
      );
      // connect to a device with its MAC address and the application uuid you want to use (in this example, serial)
      try {
        await _bluetoothClassicPlugin.connect(
          event.address,
          '00001101-0000-1000-8000-00805f9b34fb',
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(e.toString(), textAlign: TextAlign.center),
          ),
        );
      }
      // NB: I'm not doing error checking or seeing if the device is still connected in this code, check the [example folder](/example/lib/main.dart) for a more thorough demonstration
      // send data to device
      await _bluetoothClassicPlugin.write('ping');
    });
    // when you want to stop scanning
    await _bluetoothClassicPlugin.stopScan();
  }
}
