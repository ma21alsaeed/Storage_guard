import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class CustomElevatedButton extends StatelessWidget {
  final Color buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final Color? textColor;
  final Color? iconColor;
  final String? title;
  final IconData? icon;
  final OnPressed? onPressed;
  final double? horizantalPadding;
  final double? verticalPadding;
  final Widget? child;
  final double? borderRadius;

  const CustomElevatedButton(
      {Key? key,
      required this.buttonColor,
      this.splashColor,
      this.shadowColor,
      this.textColor,
      this.iconColor,
      this.title,
      this.icon,
      this.onPressed,
      this.horizantalPadding,
      this.verticalPadding,
      this.borderRadius,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed == null ? () {} : onPressed!,
      // style: ElevatedButton.styleFrom(
      //     primary: buttonColor,
      //     fixedSize: Size(50, 54),
      //     side: BorderSide(
      //       color: primaryColor,
      //       width: 1,
      //     ),
      //     shape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      //     onPrimary: splashColor),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 14)),
          side: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          backgroundColor: buttonColor,
          shadowColor: shadowColor,
          padding: EdgeInsets.symmetric(
              horizontal: horizantalPadding ?? 16,
              vertical: verticalPadding ?? 16),
          foregroundColor: splashColor),

      child: child ??
          Text(
            title == null ? 'Button' : title!,
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
          ),
    );
  }
}
