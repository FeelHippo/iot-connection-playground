import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/bloc/auth/auth_bloc.dart';
import 'package:giggle/bloc/locales/cubit.dart';
import 'package:giggle/bloc/login/cubit.dart';
import 'package:giggle/bloc/registration/cubit.dart';
import 'package:giggle/presentation/auth/auth_widget.dart';
import 'package:giggle/presentation/dependencies/injector.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ScopeConsumerWidget extends StatelessWidget {
  const ScopeConsumerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumes t Provider defined @lib/presentation/common/scope_provider_widget.dart
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? _child) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<LocaleCubit>(
              create: (BuildContext context) {
                return ioc.getDependency<LocaleCubit>();
              },
            ),
            BlocProvider<AuthBloc>(
              create: (BuildContext context) {
                return ioc.getDependency<AuthBloc>();
              },
            ),
            BlocProvider<LoginCubit>(
              create: (BuildContext context) {
                return ioc.getDependency<LoginCubit>();
              },
            ),
            BlocProvider<RegistrationCubit>(
              create: (BuildContext context) {
                return ioc.getDependency<RegistrationCubit>();
              },
            ),
          ],
          child: const AuthWidget(),
        );
      },
    );
  }
}
