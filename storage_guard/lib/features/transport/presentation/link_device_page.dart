import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/widgets/blue_title_text.dart';
import 'package:storage_guard/app/widgets/buttons/title_button.dart';
import 'package:storage_guard/bluetooth_devices_page.dart';

class LinkDevicePage extends StatelessWidget {
  const LinkDevicePage({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleButton("Cancel"),
                  const SizedBox(height: 45),
                  const BlueTitleText("Connect to Device"),
                  const SizedBox(height: 20),
                  const Text(
                    "please connect your phones to start monitoring device",
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 17,
                        fontFamily: "Inter"),
                  ),
                  const SizedBox(height: 45),
                  BluetoothDevicesWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}