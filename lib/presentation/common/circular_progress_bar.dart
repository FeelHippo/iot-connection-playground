import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar(
      {super.key, this.widgetKey, this.color, this.strokeWidth = 3});

  final Key? widgetKey;

  final Color? color;

  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      key: widgetKey,
      valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Colors.amber),
      strokeWidth: strokeWidth,
    );
  }
}
