import 'package:flutter/material.dart';

class ImageAssets {
  static String imageEndPoint = 'assets/images/';

  static Image welcome() => Image.asset(
        '${imageEndPoint}welcome.png',
        fit: BoxFit.fill,
      );
}
