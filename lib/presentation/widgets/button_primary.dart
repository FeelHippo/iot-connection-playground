import 'package:flutter/material.dart';
import 'package:giggle/presentation/themes/constants/palette.dart';
import 'package:giggle/presentation/themes/constants/spacings.dart';
import 'package:giggle/presentation/themes/constants/text_styles.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.text,
    this.onTap,
    this.trailing,
    this.bgColor,
    this.textColor,
    this.enabled = true,
  });

  static double defaultHeight = 48;

  final String text;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool enabled;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: defaultHeight,
      onPressed: enabled
          ? () {
              if (onTap != null) {
                onTap!.call();
              }
            }
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      minWidth: MediaQuery.of(context).size.width,
      color: Palette.primary,
      disabledElevation: 0.5,
      disabledColor: Palette.disabled,
      elevation: 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTextWidget(),
          if (trailing != null) _buildTrailingWidget(),
        ],
      ),
    );
  }

  Widget _buildTextWidget() {
    return Flexible(
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.header4Bold(
          color: Palette.white,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildTrailingWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        right: Spacings.small,
        left: Spacings.medium,
      ),
      child: trailing,
    );
  }
}
