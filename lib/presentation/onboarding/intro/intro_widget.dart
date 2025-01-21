import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/presentation/navigation/app_navigator.dart';
import 'package:giggle/presentation/navigation/app_routes.dart';
import 'package:giggle/presentation/splash/bloc/splash_bloc.dart';
import 'package:giggle/presentation/themes/constants/text_styles.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.bloc,
  });

  final SplashBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: bloc,
      builder: (BuildContext context, SplashState state) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          context.tr('welcome'),
                          style: TextStyles.h2Black,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          context.tr('giggle'),
                          style: TextStyles.titleBlack,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      context.tr('motto'),
                      style: TextStyles.h2Black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, SplashState state) async {
        if (state is SplashToLocalisationState) {
          AppNavigator.of(context).push(AppRoutes.localesScreen());
        }
      },
    );
  }
}
