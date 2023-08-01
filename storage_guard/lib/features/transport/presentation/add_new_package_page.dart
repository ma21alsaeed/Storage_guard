import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/blue_title_text.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/buttons/title_button.dart';
import 'package:storage_guard/features/transport/presentation/package_specifications_page.dart';

class AddNewPackagePage extends StatefulWidget {
  const AddNewPackagePage({super.key});

  @override
  State<AddNewPackagePage> createState() => _AddNewPackagePageState();
}

class _AddNewPackagePageState extends State<AddNewPackagePage> {
  List packageList = [];
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
                      const TitleButton("Cancel"),
                      const SizedBox(height: 45),
                      const BlueTitleText("Add New Package"),
                      const SizedBox(height: 20),
                      const Text(
                        "press on scan button to read QR code and add packages",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 17,
                            fontFamily: "Inter"),
                      ),
                      const SizedBox(height: 45),
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              const _PackageWidget(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: packageList.length)
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
                                    screen: const PackageSpecificationPage());
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

class _PackageWidget extends StatelessWidget {
  const _PackageWidget();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB( 20, 12,20,20),
        decoration: BoxDecoration(
          color: AppColors.blueGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Kitkat Package",
                  style: TextStyles.bodyTitleTextStyle,
                ),
                const SizedBox(width: 45),
                Text(
                  "Safe ",
                  style: TextStyles.bodyTitleTextStyle,
                ),
                const SizedBox(width: 6),
                SizedBox(
                    width: 22,
                    child: Image.asset('assets/icons/shield_small.png'))
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Manufactured by Nestlé',
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Inter"),
            )
          ],
        ),
      ),
    );
  }
}
