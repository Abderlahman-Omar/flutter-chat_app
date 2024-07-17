import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.hintColor,
      this.labelText,
      this.onChanged,
      this.obscureText = false});
  final String? hintText;
  final String? labelText;
  final Color? hintColor;
  final Function(String)? onChanged;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'This Field Is Required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: hintColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
