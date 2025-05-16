import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? textHeight;
  final FontWeight fontWeight;
  final Color? color;
  final Color? bgColor;
  final Color? decorationColor;
  final TextAlign textAlign;
  final TextOverflow? overFlow;
  final int? maxLine;
  final TextDecoration? textDecoration;

  const TextCustom({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.bgColor,
    this.decorationColor,
    this.textAlign = TextAlign.start,
    this.textHeight,
    this.overFlow,
    this.maxLine,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: textHeight,
        backgroundColor: bgColor,
        decoration: textDecoration,
        decorationColor: decorationColor,
        color: color
      ),

      textAlign: textAlign,
      overflow: maxLine != null ? overFlow ?? TextOverflow.ellipsis : null,
      maxLines: maxLine,
    );
  }
}
