import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/bloc/auth/auth_bloc.dart';
import 'package:giggle/presentation/common/app_scaffold.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: FloatingActionButton(
          child: const Icon(Icons.time_to_leave),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
          },
        ),
      ),
    );
  }
}
