import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomPopupRoute<T> extends ModalSheetRoute<T> {
  CustomPopupRoute({
    required this.widgetBuilder,
    this.theme,
    this.title,
    this.expand = false,
    this.enableDragToDismiss = true,
    this.isSwipeToDismiss = true,
    super.settings,
  }) : super(
          builder: widgetBuilder,
          expanded: expand,
        );

  final String? title;
  final WidgetBuilder widgetBuilder;
  final ThemeData? theme;
  final bool expand;
  final bool? isSwipeToDismiss;
  final bool enableDragToDismiss;

  @override
  Color get barrierColor => Colors.grey; // TODO(Filippo): define custom Palette

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isSwipeToDismiss ?? true;

  @override
  String get barrierLabel => '';

  @override
  bool get enableDrag => enableDragToDismiss;

  @override
  WidgetWithChildBuilder get containerBuilder {
    return (BuildContext context, _, Widget child) {
      Widget result;

      result = _buildContainer(context, child);
      if (theme != null) {
        result = Theme(data: theme!, child: result);
      }
      return result;
    };
  }

  Widget _buildContainer(BuildContext context, Widget child) {
    final BottomSheetThemeData bottomSheetTheme =
        Theme.of(context).bottomSheetTheme;
    final Color color =
        Colors.redAccent; // TODO(Filippo): define custom Palette
    final double effectiveElevation = bottomSheetTheme.elevation ?? 0.0;

    return SafeArea(
      bottom: false,
      child: Material(
        color: color,
        elevation: effectiveElevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
