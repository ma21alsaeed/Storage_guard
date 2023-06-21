import 'package:flutter/material.dart';
import 'package:storage_guard/app/app.dart';

void main() async{
  await StorageGuardApp.init();
  runApp(const StorageGuardApp());
}