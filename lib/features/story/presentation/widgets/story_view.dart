import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

typedef CubeWidgetBuilder =
    CubeWidget Function(BuildContext context, int index, double pageNotifier);

class CubePageView extends StatefulWidget {
  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int> onPageChanged;

  /// An object that can be used to control the position to which this page
  /// view is scrolled.
  final PageController? controller;

  /// Builder to customize your items
  final CubeWidgetBuilder? itemBuilder;

  /// The number of items you have, this is only required if you use [CubePageView.builder]
  final int itemCount;

  /// Widgets you want to use inside the [CubePageView], this is only required if you use [CubePageView] constructor
  final List<Widget>? children;

  const CubePageView({
    super.key,
    required this.onPageChanged,
    this.controller,
    required this.itemBuilder,
    required this.itemCount,
    required this.children,
  });

  @override
  State<CubePageView> createState() => _CubePageViewState();
}

class _CubePageViewState extends State<CubePageView> {

  final _pageNotifier = ValueNotifier(0.0);
  late PageController _pageController;

  void _listener() {
    _pageNotifier.value = _pageController.page!;
  }

  @override
  void initState() {
    _pageController = widget.controller ?? PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ValueListenableBuilder(valueListenable: _pageNotifier, builder: (_,value,child){
        return PageView.builder(
          controller: _pageController,
            onPageChanged: widget.onPageChanged,
            itemCount: widget.itemCount,
            itemBuilder: (_,index ){
            if(widget.itemBuilder != null){
              return widget.itemBuilder!(context, index, value);
            }
            return CubeWidget(
              child: widget.children![index],
              index: index,
              pageNotifier: value,
            );
            });
      }),
    );
  }
}

/// This widget has the logic to do the 3D cube transformation
/// It only should be used if you use [CubePageView.builder]
class CubeWidget extends StatelessWidget {
  /// Index of the current item
  final int index;

  /// Page Notifier value, it comes from the [CubeWidgetBuilder]
  final double pageNotifier;

  /// Child you want to use inside the Cube
  final Widget child;

  const CubeWidget({super.key, required this.index, required this.pageNotifier, required this.child});

  @override
  Widget build(BuildContext context) {
    print("pageNotifier ===> $pageNotifier");
    final isLeaving = (index - pageNotifier) <= 0;
    final t = (index - pageNotifier);
    final rotationY = lerpDouble(0, 90, t);
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    transform.rotateY(-degToRad(rotationY));
    return Transform(
      alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: transform,
      child: child
    );
  }

  double degToRad(double? deg) => deg! * (math.pi / 180.0);

}

