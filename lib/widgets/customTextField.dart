import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget icon;
  final bool obscureText;
  final void Function(String)? onSubmit;

  final Widget? suffixIcon;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.icon,
      this.obscureText = false,
      this.suffixIcon,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    return Container(
      width: 320.w,
      height: 48.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorSchema.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmit,
        style: TextStyle(
            color: Colors.black.withOpacity(0.9),
            decoration: TextDecoration.none),
        autocorrect: false,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            prefixIcon: icon,
            prefixIconColor: Colors.black87,
            contentPadding: const EdgeInsets.all(16),
            border: InputBorder.none,
            hintText: labelText,
            errorBorder: InputBorder.none),
      ),
    );
  }
}
