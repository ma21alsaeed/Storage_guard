import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.isObscur,
      this.onFieldSubmit,
      this.onSaved,
      this.suffix,
      this.prefix,
      this.textInputAction = TextInputAction.done,
      this.validator,
      this.fillColor = Colors.white,
      this.textColor = Colors.black,
      this.hintColor = Colors.black,
      this.controller,
      this.fontSize = 14,
      this.keyboardType = TextInputType.emailAddress,
      this.padding,
      this.hintText = '',
      this.textDirection = TextDirection.ltr,
      this.borderRadius,
      this.inputFormatters})
      : super(key: key);
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String?)? onFieldSubmit;
  final TextInputAction textInputAction;
  final bool? isObscur;
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefix;
  final Color fillColor;
  final TextInputType keyboardType;
  final Color textColor;
  final Color hintColor;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final String hintText;
  final TextDirection textDirection;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 15.0)),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 15.0)),
              borderSide: BorderSide.none),
          disabledBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 15.0)),
              borderSide: const BorderSide(
                color: Colors.red,
              )),
          hintText: hintText,
          contentPadding: padding ??
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          filled: true,
          prefixIcon: prefix,
          fillColor: fillColor,
          suffixIcon: suffix,
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: hintColor,
          )
          // prefix: prefix,
          ),
      obscuringCharacter: '*',
      style: TextStyle(
          letterSpacing: (isObscur != null && isObscur!) ? 3 : 0,
          color: textColor,
          fontSize: fontSize),
      textDirection: textDirection,
      obscureText: isObscur ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmit,
    );
  }
}
