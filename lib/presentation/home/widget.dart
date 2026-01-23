import 'package:flutter/material.dart';
import 'package:giggle/presentation/common/app_scaffold.dart';
import 'package:giggle/presentation/common/custom_text_form_field.dart';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ssidController.text = 'Sunrise_3228896';
    _passwordController.text = 'kbno4mwf4Uaavwtp';
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
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
                              const Text(
                                'WiFi Connection',
                                style: TextStyle(
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
                                        const Text(
                                          'SSID',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        CustomTextFormField(
                                          controller: _ssidController,
                                          validator: (String? value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return 'Enter valid SSID';
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
                                        const Text(
                                          'Password',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        CustomTextFormField(
                                          controller: _passwordController,
                                          validator: (String? value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return 'Enter valid password';
                                          },
                                          keyboardType: TextInputType.text,
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
                                          onPressed: _validateConnection,
                                          child: const Text(
                                            'Search for Devices',
                                            style: TextStyle(
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
      ),
    );
  }

  Future<void> _validateConnection() async {
    if (_formKey.currentState!.validate()) {
      // TODO(Filippo): add iOs permissions: https://pub.dev/packages/flutter_wifi_connect#permissions
      final bool? ok = await PluginWifiConnect.connectToSecureNetwork(
        _ssidController.text,
        _passwordController.text,
      );
      if (ok ?? false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connected to WiFi', textAlign: TextAlign.center),
          ),
        );
      }
    }
  }
}
