import 'package:flutter/cupertino.dart';
import 'package:storage/main.dart';

class LocalesWidget extends StatelessWidget {
  const LocalesWidget({
    super.key,
    required this.userPreferences,
  });

  // TODO(Filippo): use this to save locale to shared prefs
  final UserPreferences userPreferences;

  @override
  Widget build(BuildContext context) {
    // TODO(Filippo): next steps
    // store locale to shared prefs
    return Text('TBC');
  }
}
