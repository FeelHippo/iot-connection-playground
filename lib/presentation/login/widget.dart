import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/bloc/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/login/cubit.dart';
import '../common/app_scaffold.dart';
import '../common/custom_text_form_field.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.isLoggedIn) {
          BlocProvider.of<AuthBloc>(context).add(
            CompleteAuthorization(
              authenticationModel: state.authenticationModel!,
              email: state.email!,
            ),
          );
        }
      },
      child: AppScaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Login Your\nAccount',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email Address', style: TextStyle(fontSize: 14)),
                          CustomTextFormField(
                            controller: _emailController,
                            validator: (String? value) {
                              if (value != null && value.isNotEmpty) {
                                // TODO: add regex check
                                return null;
                              }
                              return 'Enter valid email';
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(72),
                            ),
                            height: 56,
                            minWidth: MediaQuery.of(context).size.width - 20,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: _validateLogin,
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              context.go('/register');
                            },
                            child: Text(
                              'Do Not Have an Account ?',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data', textAlign: TextAlign.center),
        ),
      );
    }
  }
}
