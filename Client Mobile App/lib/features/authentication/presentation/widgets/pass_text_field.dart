import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/widgets/text_form_field.dart';
import 'package:storage_guard/features/authentication/presentation/widgets/show_pass_widget.dart';

class PassTextField extends StatefulWidget {
  const PassTextField({super.key, required this.passCon});
  final TextEditingController passCon;

  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(24),
      child: CustomTextFormField(
        controller: widget.passCon,
        fillColor: AppColors.textFieldColor,
        borderRadius: 24,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        hintText: 'Password',
        textColor: AppColors.textColor,
        hintColor: Colors.grey,
        suffix: ShowPassWidget(
          showHide: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
          isHidden: isHidden,
        ),
        isObscur: isHidden,
        
      ),
    );
  }
}
