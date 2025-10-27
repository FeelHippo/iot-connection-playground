import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/bloc/auth/auth_bloc.dart';
import 'package:giggle/bloc/registration/cubit.dart';
import 'package:go_router/go_router.dart';

import '../common/app_scaffold.dart';
import '../common/custom_text_form_field.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationCubit, RegistrationState>(
      listener: (BuildContext context, RegistrationState state) {
        if (state.isLoggedIn) {
          BlocProvider.of<AuthBloc>(context).add(
            CompleteAuthorization(
              authenticationModel: state.authenticationModel!,
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
                  'Registration Your\nAccount',
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
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Password', style: TextStyle(fontSize: 14)),
                          CustomTextFormField(
                            controller: _passwordController,
                            validator: (String? value) {
                              if (value != null && value.isNotEmpty) {
                                // TODO: add regex check
                                return null;
                              }
                              return 'Enter valid password';
                            },
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          Text(
                            'Forgot Password ?',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Confirm Password',
                            style: TextStyle(fontSize: 14),
                          ),
                          CustomTextFormField(
                            controller: _confirmPasswordController,
                            validator: (String? value) {
                              if (value != null && value.isNotEmpty) {
                                // TODO: add regex check
                                return null;
                              }
                              return 'Enter valid password';
                            },
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          Text(
                            'Forgot Password ?',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Username', style: TextStyle(fontSize: 14)),
                          CustomTextFormField(
                            controller: _usernameController,
                            validator: (String? value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return 'Enter valid email';
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('First Name', style: TextStyle(fontSize: 14)),
                          CustomTextFormField(
                            controller: _firstNameController,
                            validator: (String? value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return 'Enter valid email';
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Last Name', style: TextStyle(fontSize: 14)),
                          CustomTextFormField(
                            controller: _lastNameController,
                            validator: (String? value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return 'Enter valid email';
                            },
                            keyboardType: TextInputType.text,
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
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: _validateRegistration,
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: Text(
                              'I Do Have an Account',
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

  void _validateRegistration() {
    if (_formKey.currentState!.validate()) {
      context.read<RegistrationCubit>().register(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data', textAlign: TextAlign.center),
        ),
      );
    }
  }
}
