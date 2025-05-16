import 'package:flutter/material.dart';

extension PaddingEx on Widget {
  Widget paddingTop(double value) =>
      Padding(padding: EdgeInsetsDirectional.only(top: value), child: this);
  Widget paddingBottom(double value) =>
      Padding(padding: EdgeInsetsDirectional.only(bottom: value), child: this);
  Widget paddingStart(double value) =>
      Padding(padding: EdgeInsetsDirectional.only(start: value), child: this);
  Widget paddingEnd(double value) =>
      Padding(padding: EdgeInsetsDirectional.only(end: value), child: this);

  Widget paddingSymmetric({double? vertical, double? horizontal}) =>
      Padding(padding: EdgeInsetsDirectional.symmetric(vertical: vertical ?? 0,horizontal: horizontal ?? 0), child: this);
  Widget paddingDirectionalOnly({
    double? start,
    double? end,
    double? top,
    double? bottom,
  }) => Padding(
    padding: EdgeInsetsDirectional.only(
      start: start ?? 0,
      end: end ?? 0,
      top: top ?? 0,
      bottom: bottom ?? 0,
    ),
    child: this,
  );
}

extension MyThemeExtension on BuildContext {
  ThemeData get myTheme => Theme.of(this);
  TextTheme get myTextTheme => myTheme.textTheme;
}
