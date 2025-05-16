import 'package:flutter/material.dart';

abstract class MyApiStatus {
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  });
}

// -------------------- STATUS IMPLEMENTATIONS --------------------

// Loading State
class Loading implements MyApiStatus {
  @override
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  }) {
    return loadingWidget?.call() ??
        const Center(child: CircularProgressIndicator());
  }
}

// Success State
class Success implements MyApiStatus {
  @override
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  }) {
    return successWidget();
  }
}

// Error State
class Error implements MyApiStatus {
  final String message;

  Error({required this.message});
  @override
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  }) {
    return errorWidget(message);
  }
}

// Empty State
class Empty implements MyApiStatus {
  @override
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  }) {
    return emptyWidget?.call() ??
        const Center(child: Text("No Data Available"));
  }
}

// Holding State
class Holding implements MyApiStatus {
  @override
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  }) {
    return holdingWidget?.call() ?? const SizedBox.shrink();
  }
}

// Refreshing State
class Refreshing implements MyApiStatus {
  @override
  Widget returnWidget({
    required hideSuccess,
    Widget Function()? loadingWidget,
    required Widget Function() successWidget,
    required Widget Function(String) errorWidget,
    Widget Function()? emptyWidget,
    Widget Function()? holdingWidget,
    Widget Function()? refreshWidget,
  }) {
    if (hideSuccess) {
      return refreshWidget?.call() ?? const SizedBox.shrink();
    }
    return successWidget();
  }
}
