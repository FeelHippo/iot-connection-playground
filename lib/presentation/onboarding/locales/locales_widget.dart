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
        AppNavigator.of(context).push(
          AppRoutes.termsAndConditionsScreen(),
        );
      },
      child: Column(
        children: <Widget>[
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) - 124,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -12,
                  bottom: -8,
                  child: Container(
                    height: (MediaQuery.of(context).size.height / 4) - 8,
                    width: (MediaQuery.of(context).size.width / 2) - 8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ImageAssets.dialogueRight().image,
                        invertColors: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    height: (MediaQuery.of(context).size.height / 4) - 8,
                    width: (MediaQuery.of(context).size.width / 2) - 8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ImageAssets.dialogueLeft().image,
                        invertColors: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  child: GestureDetector(
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4) - 8,
                      width: (MediaQuery.of(context).size.width / 2) - 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ImageAssets.dialogueLeft().image,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.1),
                        child: Text(
                          'Italiano',
                          style: TextStyles.h2BlackBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.read<LocaleCubit>().saveLocaleToPrefs(
                            locale: Locale(
                              'it',
                            ),
                          );
                    },
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: GestureDetector(
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4) - 8,
                      width: (MediaQuery.of(context).size.width / 2) - 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ImageAssets.dialogueRight().image,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.1),
                        child: Text(
                          'Français',
                          style: TextStyles.h2BlackBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.read<LocaleCubit>().saveLocaleToPrefs(
                            locale: Locale(
                              'fr',
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 124,
            child: Text(
              context.tr('giggle'),
              style: TextStyles.titleBlack,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: 16,
                  bottom: -16,
                  child: Container(
                    height: (MediaQuery.of(context).size.height / 4) - 8,
                    width: (MediaQuery.of(context).size.width / 2) - 8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ImageAssets.dialogueLeft().image,
                        invertColors: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -8,
                  top: 8,
                  child: Container(
                    height: (MediaQuery.of(context).size.height / 4) - 8,
                    width: (MediaQuery.of(context).size.width / 2) - 8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ImageAssets.dialogueLeft().image,
                        invertColors: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 112,
                  right: 16,
                  child: Container(
                    height: (MediaQuery.of(context).size.height / 4) - 8,
                    width: (MediaQuery.of(context).size.width / 2) - 8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ImageAssets.dialogueLeft().image,
                        invertColors: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -24,
                  child: GestureDetector(
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4) - 8,
                      width: (MediaQuery.of(context).size.width / 2) - 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ImageAssets.dialogueLeft().image,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.1),
                        child: Text(
                          'English',
                          style: TextStyles.h2BlackBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.read<LocaleCubit>().saveLocaleToPrefs(
                            locale: Locale(
                              'en',
                            ),
                          );
                    },
                  ),
                ),
                Positioned(
                  bottom: 120,
                  right: 8,
                  child: GestureDetector(
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4) - 8,
                      width: (MediaQuery.of(context).size.width / 2) - 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ImageAssets.dialogueLeft().image,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.1),
                        child: Text(
                          'Deutsch',
                          style: TextStyles.h2BlackBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.read<LocaleCubit>().saveLocaleToPrefs(
                            locale: Locale(
                              'de',
                            ),
                          );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 8,
                  child: GestureDetector(
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4) - 8,
                      width: (MediaQuery.of(context).size.width / 2) - 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ImageAssets.dialogueLeft().image,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.1),
                        child: Text(
                          'Espagnol',
                          style: TextStyles.h2BlackBold,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.read<LocaleCubit>().saveLocaleToPrefs(
                            locale: Locale(
                              'es',
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
