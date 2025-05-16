import 'package:flutter/material.dart';
import 'package:instagram_clone/config/theme.dart';

mixin Common{

  static void showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor:AppTheme.sheetBgColor,
      showDragHandle:true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return child;
          },
        );
      },
    );
  }

}