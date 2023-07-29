import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/widgets/blue_title_text.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/features/qrcode/presentation/qr_view_page.dart';
import 'package:storage_guard/features/transport/presentation/package_specifications_page.dart';

class AddNewPackagePage extends StatelessWidget {
  const AddNewPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Color(0xFF1E1E1E), fontSize: 18),
                          )),
                      const SizedBox(height: 45),
                      BlueTitleText("Add New Package"),
                      const SizedBox(height: 20),
                      Text(
                        "press on scan button to read QR code and add packages",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 17,
                            fontFamily: "Inter"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GradientButton(
                              withArrow: false,
                              title: "Scan",
                              onPressed: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    withNavBar: false,
                                    screen: PackageSpecificationPage());
                                // PersistentNavBarNavigator.pushNewScreen(context,
                                //         withNavBar: false, screen: QRViewPage())
                                //     .then((value) {
                                //   if (value.contains("api/v1")) {
                                //     PersistentNavBarNavigator.pushNewScreen(
                                //         context,
                                //         withNavBar: false,
                                //         screen: PackageSpecificationPage());
                                //   } else {
                                //     Fluttertoast.showToast(
                                //         msg:
                                //             "This is not a storage guard QR Code");
                                //   }
                                // });
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
