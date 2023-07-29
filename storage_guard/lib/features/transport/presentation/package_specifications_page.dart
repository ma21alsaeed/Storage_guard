import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/blue_title_text.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';

class PackageSpecificationPage extends StatelessWidget {
  const PackageSpecificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style:
                            TextStyle(color: Color(0xFF1E1E1E), fontSize: 18),
                      )),
                  const SizedBox(height: 38),
                  const BlueTitleText("Specifications"),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text("Product Name", style: TextStyles.regularTextStyle),
                      const SizedBox(width: 52),
                      Text("Safe", style: TextStyles.regularTextStyle),
                      const SizedBox(width: 10),
                      SizedBox(
                          width: 26,
                          child: Image.asset('assets/icons/shield_small.png')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("KitKat Biscuit", style: TextStyles.smallLightTextStyle),
                  const SizedBox(height: 16),
                  Text("Manufactured by", style: TextStyles.regularTextStyle),
                  const SizedBox(height: 8),
                  Text("Nestlé", style: TextStyles.smallLightTextStyle),
                  const SizedBox(height: 16),
                  Text("Production Date", style: TextStyles.regularTextStyle),
                  const SizedBox(height: 8),
                  Text("2023 / 01 / 03", style: TextStyles.smallLightTextStyle),
                  const SizedBox(height: 16),
                  Text("Expiration date", style: TextStyles.regularTextStyle),
                  const SizedBox(height: 8),
                  Text("2024 / 01 / 03", style: TextStyles.smallLightTextStyle),
                  const SizedBox(height: 22),
                  Text("Value Range", style: TextStyles.regularTextStyle),
                  const Divider(
                    height: 40,
                    color: Colors.black54,
                  ),
                  const _TableSection(),
                  const SizedBox(height: 38),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: const Text(
                            "Do you want to add this package or not?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: GradientButton(
                          title: "No",
                          withArrow: false,
                          onPressed: () {},
                        )),
                        SizedBox(width: 20),
                        Expanded(
                            child: GradientButton(
                          title: "Add",
                          withArrow: false,
                          onPressed: () {},
                        )),
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

class _TableSection extends StatelessWidget {
  const _TableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(),
      children: [
        const TableRow(
          decoration: BoxDecoration(border: Border.symmetric()),
          children: [
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Min'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Max'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('AVG'),
              ),
            ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border(
              top: BorderSide(width: 1, color: Colors.grey),
              bottom: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text('Temp'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("20"),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("20"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text("20"),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Humidity'),
              ),
            ),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("20"),
            )),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("20"),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("20"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
