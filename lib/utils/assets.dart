import 'package:flutter/material.dart';

class ImageAssets {
  static String imageEndPoint = 'assets/images/';

  static Image dialogueRight() => Image.asset(
        '${imageEndPoint}dialogue_right.png',
        fit: BoxFit.fill,
      );

  static Image dialogueLeft() => Image.asset(
        '${imageEndPoint}dialogue_left.png',
        fit: BoxFit.fill,
      );
}
