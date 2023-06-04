import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  const CustomDropDownWidget(
      {super.key,
      required this.value,
      required this.dropDownList,
      required this.onChanged});
  final List<DropdownMenuItem<T>> dropDownList;
  final T value;
  final void Function(T? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: AppColors.mainorange),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: AppColors.mainorange),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        value: value,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        items: dropDownList);
  }
}
