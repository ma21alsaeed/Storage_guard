import 'package:flutter/material.dart';

extension SnackBarBuildContextExtension on BuildContext {
  // Future<void> copyToClipboard(String text,
  //     {String? message = 'تم النسخ بنجاح',
  //     IconData? icon = Icons.copy_rounded}) async {
  //   await Clipboard.setData(ClipboardData(text: text));
  //   if (message != null) {
  //     showBasicSnackBar(message, icon: icon);
  //   }
  // }

  void removeSnackBar(
          {SnackBarClosedReason reason = SnackBarClosedReason.hide}) =>
      ScaffoldMessenger.of(this).removeCurrentSnackBar(reason: reason);

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }

  void showCopySnackBar() =>
      showBasicSnackBar('تم النسخ إلى الحافظة', icon: Icons.copy_rounded);

  void showSaveSuccessSnackBar() => showSuccessSnackBar('تم الحفظ بنجاح');

  void showSaveFailSnackBar() => showFailSnackBar('فشل حفظ التغييرات');

  void showFailSnackBar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) =>
      showBasicSnackBar(
        message,
        icon: Icons.error_rounded,
        iconColor: Theme.of(this).colorScheme.error,
        duration: duration,
        action: action,
      );

  void showSuccessSnackBar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) =>
      showBasicSnackBar(
        message,
        icon: Icons.check_circle_rounded,
        iconColor: Colors.green,
        duration: duration,
        action: action,
      );

  void showBasicSnackBar(
    String message, {
    IconData? icon,
    Color? iconColor,
    Duration? duration,
    SnackBarAction? action,
  }) {
    final text = Text(message);
    showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(milliseconds: 4000),
        content: icon == null
            ? text
            : Row(
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(height: 12,),
                  Text(message),
                ],
              ),
        action: action,
      ),
    );
  }
}
