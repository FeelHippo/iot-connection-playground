import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dependencies/injector.dart';
import 'widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? child) {
        return const HomeWidget();
      },
    );
  }
}
