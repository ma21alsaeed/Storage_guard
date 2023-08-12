import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors.dart';

class ControlButtons extends StatelessWidget {
  final List<bool> isSelected;
  final void Function(int index)? onPressed;
  const ControlButtons({super.key, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ToggleButtons(
        color: AppColors.mainblue,
        onPressed:onPressed,
        isSelected: isSelected,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Product'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Clone'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('User'),
          ),
        ],
      ),
    );
  }
}
