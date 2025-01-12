import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_active/injector.dart';
import 'package:go_active/presentation/onboarding/auth/auth_bloc/auth_bloc.dart';
import 'package:go_active/presentation/onboarding/auth/auth_widget.dart';
import 'package:go_active/presentation/splash/bloc/splash_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? child) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<AuthBloc>(
              create: (BuildContext context) {
                return ioc.getDependency<AuthBloc>()..add(FetchAuthEvent());
              },
            ),
            BlocProvider<SplashBloc>(
              create: (BuildContext context) {
                return ioc.getDependency<SplashBloc>();
              },
            ),
          ],
          child: AuthWidget(),
        );
      },
    );
  }
}
