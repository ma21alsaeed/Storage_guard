import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';

class AddNewPackagePage extends StatelessWidget {
  const AddNewPackagePage({super.key});

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
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 18),
                    )),
                    const SizedBox(height: 45),
                    Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 18),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
