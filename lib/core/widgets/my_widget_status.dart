import 'package:flutter/material.dart';
import 'package:instagram_clone/core/api_call_status.dart';

class MyWidgetsAnimator extends StatelessWidget {
  final MyApiStatus apiCallStatus;
  final Widget Function()? loadingWidget;
  final Widget Function() successWidget;
  final Widget Function(String) errorWidget;
  final Widget Function()? emptyWidget;
  final Widget Function()? holdingWidget;
  final Widget Function()? refreshWidget;
  final Duration animationDuration;
  final Widget Function(Widget, Animation<double>) transitionBuilder;
  final bool hideSuccessWidgetWhileRefreshing;

  const MyWidgetsAnimator({
    super.key,
    required this.apiCallStatus,
    this.loadingWidget,
    required this.errorWidget,
    required this.successWidget,
    this.emptyWidget,
    this.holdingWidget,
    this.refreshWidget,
    this.animationDuration = const Duration(milliseconds: 300),
    this.transitionBuilder = defaultTransitionBuilder,
    this.hideSuccessWidgetWhileRefreshing = false,
  });

  static Widget defaultTransitionBuilder(
    Widget child,
    Animation<double> animation,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: animationDuration,
      transitionBuilder: transitionBuilder,
      child: _getChild(apiCallStatus),
    );
  }

  Widget _getChild(MyApiStatus status) {
    return status.returnWidget(
      hideSuccess: hideSuccessWidgetWhileRefreshing,
      loadingWidget: loadingWidget,
      successWidget: successWidget,
      errorWidget: errorWidget,
      emptyWidget: emptyWidget,
      holdingWidget: holdingWidget,
      refreshWidget: refreshWidget,
    );
  }
}
