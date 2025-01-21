import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giggle/presentation/navigation/app_navigator.dart';
import 'package:giggle/presentation/navigation/app_routes.dart';
import 'package:giggle/presentation/onboarding/locales/cubit.dart';
import 'package:giggle/presentation/themes/constants/text_styles.dart';
import 'package:giggle/utils/assets.dart';

class LocalesWidget extends StatelessWidget {
  const LocalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocaleCubit, Locale>(
      listener: (BuildContext context, Locale state) {
        AppNavigator.of(context).push(AppRoutes.termsAndConditionsScreen());
      },
      child: SafeArea(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ImageAssets.dialogueLeft().image,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Italiano',
                                      style: TextStyles.h1BlackBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              context
                                  .read<LocaleCubit>()
                                  .saveThemeToPrefs(locale: Locale('it'));
                            },
                          ),
                        ],
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
      ),
    );
  }
}
