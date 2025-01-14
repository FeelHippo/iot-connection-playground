import 'package:flutter/cupertino.dart';
import 'package:giggle/injector.dart';
import 'package:giggle/presentation/navigation/app_navigator.dart';
import 'package:giggle/presentation/onboarding/intro/intro_widget.dart';
import 'package:giggle/presentation/splash/bloc/splash_bloc.dart';
import 'package:giggle/presentation/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key, required this.rootNavigatorKey});

  final GlobalKey<NavigatorState> rootNavigatorKey;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Consumer<IOC>(
        builder: (BuildContext context, IOC ioc, Widget? child) {
          final SplashBloc splashBloc = ioc.getDependency<SplashBloc>()
            // IntroEvent will trigger navigation to the carousel
            ..add(IntroEvent());

          return Provider<AppNavigator>(
            create: (BuildContext context) => AppNavigator(rootNavigatorKey),
            child: IntroWidget(
              bloc: splashBloc,
            ),
          );
        },
      ),
    );
  }
}
