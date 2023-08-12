import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart';
import 'package:storage_guard_dashboard/pages/home_page.dart';
import 'pages/create_product.dart';
import 'pages/signup_page.dart';

void main() async {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScreenUtilInit(
      designSize: kIsWeb ? const Size(1200, 800) : const Size(800, 600),
      builder: (context, child) => HomePage(),
    ),
  ));
}
