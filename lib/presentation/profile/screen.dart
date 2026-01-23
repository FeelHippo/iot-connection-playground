import 'package:flutter/material.dart';
import 'package:giggle/presentation/dependencies/injector.dart';
import 'package:giggle/presentation/profile/widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? child) {
        return const ProfileWidget();
      },
    );
  }
}
