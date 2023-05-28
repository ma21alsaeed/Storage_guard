import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/widgets/text_form_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField(
      {super.key, required this.emailCon, this.isSignUp = false});
  final TextEditingController emailCon;
  final bool isSignUp;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(24),
      child: CustomTextFormField(
        controller: emailCon,
        fillColor: AppColors.textFieldColor,
        hintText: isSignUp ? "Email" : 'Username or Email',
        textDirection: TextDirection.ltr,
        hintColor: Colors.grey,
        borderRadius: 24,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        textColor: AppColors.textColor,
        validator: (text) {
          if (text!.isEmpty) {
            return 'email should not be empty';
          }
          return null;
        },
      ),
    );
  }
}
