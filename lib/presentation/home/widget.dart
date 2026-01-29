import 'package:flutter/material.dart';
import 'package:giggle/presentation/home/models/render_model.dart';
import 'package:giggle/presentation/home/widgets/blue_tooth_plus.dart';
import 'package:giggle/presentation/home/widgets/mqtt_client_aws_iot_core.dart';
import 'package:giggle/presentation/home/widgets/mqtt_client_aws_websocket.dart';
import 'package:giggle/presentation/home/widgets/plugin_wifi_connect.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  static const String SSID = 'Sunrise_3228896';
  static const String password = 'kbno4mwf4Uaavwtp';
  static List<Widget> widgetsWiFi = <Widget>[
    const PluginWifiConnectWidget(SSID: SSID, password: password),
  ];
  static List<Widget> widgetsMQTT = <Widget>[
    const MqttClientAwsIotCoreWidget(),
    const MqttClientAwsWebSocketWidget(),
  ];
  static List<Widget> widgetsBlueTooth = <Widget>[const BlueToothPlusWidget()];

  static List<RenderModel> renderGroups = <RenderModel>[
    RenderModel(title: 'WiFi', widgets: widgetsWiFi),
    RenderModel(title: 'MQTT', widgets: widgetsMQTT),
    RenderModel(title: 'BlueTooth', widgets: widgetsBlueTooth),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: renderGroups
            .map(
              (RenderModel model) => Column(
                children: <Widget>[
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: model.widgets.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, int index) => Card(
                              color: Theme.of(context).cardColor,
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: model.widgets[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
