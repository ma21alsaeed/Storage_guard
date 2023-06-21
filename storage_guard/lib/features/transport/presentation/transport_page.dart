import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';

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
                const SizedBox(height: 16),
                const _AddPackageSection(),
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
            children: [
              Text(
                "Count    15",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "All Safe",
                    style: TextStyles.regularTextStyle,
                  ),
                  const SizedBox(width: 10)
                  SizedBox(width: 6,child: Image.asset(name),)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
