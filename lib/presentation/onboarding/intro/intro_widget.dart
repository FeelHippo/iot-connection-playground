import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_active/presentation/navigation/app_navigator.dart';
import 'package:go_active/presentation/onboarding/carousel/carousel_widget.dart';
import 'package:go_active/presentation/splash/bloc/splash_bloc.dart';
import 'package:go_active/utils/assets.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key, required this.bloc});

  final SplashBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: bloc,
      builder: (BuildContext context, SplashState state) {
        return Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ImageAssets.welcome(),
            ),
            Positioned(
              bottom: 0,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Text(
                      'GoActive \ntraining',
                      style: TextStyle(
                        height: 0,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'The best AI running app in this century \nto accompany your training',
                      style: TextStyle(
                        height: 0,
                        fontSize: 20,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      listener: (BuildContext context, SplashState state) async {
        if (state is SplashToRegistrationState) {
          AppNavigator.navigatePage(
            context: context,
            className: CarouselWidget(),
          );
        }
      },
    );
  }
}
