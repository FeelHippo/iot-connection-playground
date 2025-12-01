import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/bloc/auth/auth_bloc.dart';
import 'package:giggle/bloc/locales/cubit.dart';
import 'package:giggle/presentation/router/go_router.dart';

import '../themes/theme.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(FetchAuthEvent()),
      builder: (BuildContext context, AuthState state) {
        final AuthUiModel authStatus = state.auth;
        // see go_router's "Dynamic RoutingConfig"
        // https://pub.dev/documentation/go_router/latest/topics/Configuration-topic.html

        if (authStatus is UnauthorizedAuthUiModel) {
          routingConfig.value = unauthorizedRoutingConfig;
        }
        if (authStatus is AuthorizedAuthUiModel) {
          routingConfig.value = authorizedRoutingConfig(
            authStatus.userData.needsMoreData,
          );
        }

        return BlocBuilder<LocaleCubit, Locale>(
          builder: (BuildContext context, Locale locale) {
            return MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              theme: AppTheme.lightTheme(),
              routerConfig: router,
              locale: locale,
            );
          },
        );
      },
    );
  }
}
