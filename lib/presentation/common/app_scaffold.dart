import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giggle/presentation/common/connectivity_widget.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.systemUiOverlayStyleIOS = SystemUiOverlayStyle.light,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomPadding = true,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final SystemUiOverlayStyle? systemUiOverlayStyleIOS;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomPadding;

  @override
  AppScaffoldState createState() => AppScaffoldState();

  static AppScaffoldState? of(BuildContext context) {
    final AppScaffoldState? result = context
        .findAncestorStateOfType<AppScaffoldState>();
    assert(
      result != null,
      throw 'Error: lib/presentation/widgets/app_scaffold.dart '
          'AppScaffold.of() called with a context '
          'that does not contain a AppScaffold.',
    );
    return result;
  }
}

class AppScaffoldState extends State<AppScaffold> {
  List<AppSnackBar> _snackBars = <AppSnackBar>[];
  final StreamController<List<AppSnackBar>> _controller =
      StreamController<List<AppSnackBar>>();

  void showSnackBar(AppSnackBar snackBar) {
    final int index = snackBar.key != null
        ? _snackBars.indexWhere((AppSnackBar s) => s.key == snackBar.key)
        : -1;
    final List<AppSnackBar> snackBars = List<AppSnackBar>.from(_snackBars);
    if (index < 0) {
      snackBars
        ..add(snackBar)
        ..sort(
          (AppSnackBar a, AppSnackBar b) => b.priority.compareTo(a.priority),
        );
    }
    _controller.add(snackBars);
    _snackBars = snackBars;
  }

  void removeSnackBar(Key key) {
    final int index = _snackBars.indexWhere(
      (AppSnackBar snackBar) => snackBar.key == key,
    );
    if (index > -1) {
      final List<AppSnackBar> snackBars = List<AppSnackBar>.from(_snackBars)
        ..removeAt(index);
      _controller.add(snackBars);
      _snackBars = snackBars;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.appBar == null && Platform.isIOS) {
      child = AnnotatedRegion<SystemUiOverlayStyle>(
        value:
            widget.systemUiOverlayStyleIOS ??
            _themeSystemUiOverlayStyle(context),
        child: widget.body,
      );
    } else {
      child = widget.body;
    }

    return Scaffold(
      appBar: widget.appBar,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomPadding,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Stack(
        children: <Widget>[
          child,
          ConnectivityContainerWidget(),
          SafeArea(
            child: StreamBuilder<List<AppSnackBar>>(
              stream: _controller.stream,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<AppSnackBar>> snapshot,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: snapshot.data ?? <Widget>[],
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }

  SystemUiOverlayStyle _themeSystemUiOverlayStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SystemUiOverlayStyle overlayStyle =
        theme.brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    return overlayStyle;
  }
}

enum AppSnackBarSeverity { info, success, error }

class AppSnackBar extends StatefulWidget {
  const AppSnackBar({
    super.key,
    this.content,
    this.action,
    this.actionCallback,
    this.severity,
    int? priority,
    bool? permanent,
    bool? isBottomPadding,
    this.margin,
    this.onTap,
  }) : priority = priority ?? (action != null ? priorityNormal : priorityJ),
       permanent = permanent ?? action != null,
       isBottomPadding = isBottomPadding ?? false;
  static const int priorityHigh = 0;
  static const int priorityNormal = 1;
  static const int priorityJ = 2;

  static const double minHeight = 32;

  final Widget? content;
  final Widget? action;
  final VoidCallback? actionCallback;
  final AppSnackBarSeverity? severity;
  final int priority;
  final bool permanent;

  /// This is used for iOS only cause of bottom button in iOS
  final bool isBottomPadding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  @override
  _AppSnackBarState createState() => _AppSnackBarState();
}

class _AppSnackBarState extends State<AppSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _prepareAnimation();
    _controller.forward();

    if (!widget.permanent) {
      _timer = Timer(const Duration(seconds: 4), () => _controller.reverse());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!.call();
          }
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: AppSnackBar.minHeight),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _buildBackgroundColor(),
          ),
          margin:
              widget.margin ??
              EdgeInsets.only(
                bottom: Platform.isIOS
                    ? widget.isBottomPadding
                          ? 24
                          : 4
                    : 4,
                left: 4,
                right: 4,
              ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6),
                child: DefaultTextStyle.merge(
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  child: widget.content ?? const SizedBox(),
                ),
              ),
              if (widget.action != null) _buildAction(),
            ],
          ),
        ),
      ),
    );
  }

  Color _buildBackgroundColor() {
    switch (widget.severity) {
      case AppSnackBarSeverity.error:
        return Colors.red;
      case AppSnackBarSeverity.info:
        return Colors.blue;
      case AppSnackBarSeverity.success:
        return Colors.green;
      case null:
        return Colors.blue;
    }
  }

  Widget _buildAction() {
    return Positioned(
      right: 0,
      child: InkWell(onTap: widget.actionCallback, child: widget.action),
    );
  }

  void _prepareAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 333),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }
}
