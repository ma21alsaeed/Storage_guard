import 'package:flutter/material.dart';

extension BottomSheetWidgetExtension on Widget {
  Future<T?> showAsBottomSheet<T>(
    BuildContext context, {
    bool isScrollControlled = false,
    Color? backgroundColor,
  }) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: backgroundColor,
        isScrollControlled: isScrollControlled,
        builder: (context) => this,
      );
}
