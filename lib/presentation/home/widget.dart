import 'package:flutter/material.dart';
import 'package:giggle/presentation/home/widgets/plugin_wifi_connect.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  static const String SSID = 'Sunrise_3228896';
  static const String password = 'kbno4mwf4Uaavwtp';
  static List<Widget> widgets = <Widget>[
    const PluginWifiConnectWidget(SSID: SSID, password: password),
    const PluginWifiConnectWidget(SSID: SSID, password: password),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: widgets.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) => Card(
                    color: Theme.of(context).cardColor,
                    clipBehavior: Clip.hardEdge,
                    child: widgets[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
