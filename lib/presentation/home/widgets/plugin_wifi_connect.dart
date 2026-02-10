import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:giggle/presentation/common/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PluginWifiConnectWidget extends StatefulWidget {
  const PluginWifiConnectWidget({
    super.key,
    required this.SSID,
    required this.password,
  });

  final String SSID;
  final String password;

  @override
  State<StatefulWidget> createState() => _PluginWifiConnectWidgetState();
}

class _PluginWifiConnectWidgetState extends State<PluginWifiConnectWidget> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ssidController.text = widget.SSID;
    _passwordController.text = widget.password;
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          child: const Text('WiFI Connect', style: TextStyle(fontSize: 20)),
          onTap: () => launchUrl(
            Uri.parse('https://github.com/chenrilima/plugin_wifi_connect'),
          ),
        ),
        FloatingActionButton(
          mini: true,
          key: const Key('plugin_wifi_connect'),
          heroTag: 'plugin_wifi_connect',
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.amber,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                context.tr('connection_bottom_sheet_title'),
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          context.tr(
                                            'connection_bottom_sheet_ssid',
                                          ),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        CustomTextFormField(
                                          controller: _ssidController,
                                          validator: (String? value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return context.tr(
                                              'connection_bottom_sheet_ssid_error',
                                            );
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          context.tr(
                                            'connection_bottom_sheet_password',
                                          ),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        CustomTextFormField(
                                          controller: _passwordController,
                                          validator: (String? value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return context.tr(
                                              'connection_bottom_sheet_password_error',
                                            );
                                          },
                                          keyboardType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        MaterialButton(
                                          color: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              72,
                                            ),
                                          ),
                                          height: 56,
                                          minWidth:
                                              MediaQuery.of(
                                                context,
                                              ).size.width -
                                              20,
                                          onPressed: _searchDevices,
                                          child: Text(
                                            context.tr(
                                              'connection_bottom_sheet_search',
                                            ),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Future<void> _searchDevices() async {
    if (_formKey.currentState!.validate()) {
      // TODO(Filippo): add iOs permissions: https://pub.dev/packages/flutter_wifi_connect#permissions
      // Make sure device is connected to Arduino AP
      // which is available when IoT device is running the firmware
      // SSID "smartThing" PASS "12345678"
      final Uri urlCheck = Uri.http('192.168.4.1');
      final http.Response check = await http.get(urlCheck);
      if (check.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              context.tr('connection_bottom_sheet_pa_not_connected'),
              textAlign: TextAlign.center,
            ),
          ),
        );
        return;
      }
      final Uri urlConnect = Uri.http('192.168.4.1', 'wifi');
      final http.Response response = await http.post(
        urlConnect,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'ssid': widget.SSID,
          'pwd': widget.password,
        }),
      );
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(response.body, textAlign: TextAlign.center),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.tr('connection_bottom_sheet_connected'),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }
}
