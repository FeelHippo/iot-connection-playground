import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/injector.dart';
import 'package:giggle/presentation/onboarding/auth/auth_bloc/auth_bloc.dart';
import 'package:giggle/presentation/onboarding/intro/intro_screen.dart';
import 'package:giggle/presentation/widgets/circular_progress_bar.dart';
import 'package:giggle/presentation/widgets/custom_navigator.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (BuildContext context, AuthState state) => AuthStateWidget(
        state: state,
        authBloc: authBloc,
      ),
    );
  }
}

class AuthStateWidget extends StatelessWidget {
  const AuthStateWidget({Key? key, required this.state, required this.authBloc})
      : super(key: key);
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  final AuthState state;
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    Widget child;
    final AuthState state = this.state;
    final AuthUiModel? auth = state.auth;

    if (state.loading == Loading.initializing) {
      child = const Scaffold(
        body: Center(
          child: CircularProgressBar(),
        ),
      );
    } else if (auth is DeleteAccountUiModel) {
      // TODO(Filippo): define DeleteAccountConfirmScreen()
      child = Container();
    } else if (auth is UnauthorizedAuthUiModel) {
      child = CustomNavigator(
        navigatorKey: rootNavigatorKey,
        onGenerateRoute: (_) => PageRouteBuilder<dynamic>(
          pageBuilder: (_, __, ___) => IntroScreen(
            rootNavigatorKey: rootNavigatorKey,
          ),
        ),
      );
    } else if (auth is AuthorizedAuthUiModel) {
      // TODO(Filippo): define HomeScreen()
      child = Consumer<IOC>(
        builder: (BuildContext context, IOC ioc, Widget? child) {
          return CustomNavigator(
            navigatorKey: rootNavigatorKey,
            onGenerateRoute: (_) => PageRouteBuilder<dynamic>(
                pageBuilder: (_, __, ___) => Container()
                //     HomeScreen(
                //   rootNavigatorKey: rootNavigatorKey,
                //   userPreferences: ioc.getDependency<UserPreferences>(),
                // ),
                ),
          );
        },
      );
    } else {
      child = const Scaffold(
        body: Center(
          child: CircularProgressBar(),
        ),
      );
    }
    return child;
  }
}
