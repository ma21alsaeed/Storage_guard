import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StorageGuardQrCode extends StatelessWidget {
  final String data;
  const StorageGuardQrCode({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data:data,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
