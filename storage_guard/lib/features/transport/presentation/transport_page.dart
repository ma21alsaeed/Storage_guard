import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';

class TransportPage extends StatelessWidget {
  const TransportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleAppBar(),
                const SizedBox(height: 45),
                const _AddPackageSection(),
                const SizedBox(height: 25),
                const _AddDevicesSection(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GradientButton(
                      title: "Create",
                      onPressed: () {},
                      withArrow: false,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddPackageSection extends StatelessWidget {
  const _AddPackageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider("Add Packages"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Count    15",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    "All Safe",
                    style: TextStyles.regularTextStyle,
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 26,
                    child: Image.asset("assets/icons/shield_small.png"),
                  )
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    title: "Add",
                    onPressed: () {},
                    withArrow: false,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _AddDevicesSection extends StatelessWidget {
  const _AddDevicesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider("Link Device"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Device Name",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 14),
              Text(
                "Monitoring Device C1",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 14),
              Text(
                "Device Battery",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 14),
              Text(
                "80%",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    title: "Link",
                    onPressed: () {},
                    withArrow: false,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
