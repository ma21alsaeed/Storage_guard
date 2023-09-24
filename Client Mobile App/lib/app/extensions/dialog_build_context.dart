import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart' as material_dialog show showDialog;

extension DialogBuildContextExtension on BuildContext{
  Future<T?> showDialog<T>(Widget dialog, {bool barrierDismissible = true}) {
    return material_dialog.showDialog<T>(
      context: this,
      builder: (context) => dialog,
      barrierDismissible: barrierDismissible,
      
    );
  }
}