import 'package:authenticatorx/data/colors.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    this.obsecureText = false,
    required this.icon,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
  });

  final String labelText;
  final bool obsecureText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: greyColor),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );

    return TextFormField(
      cursorColor: blackColor,
      obscureText: obsecureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelStyle: const TextStyle(color: blackColor),
        labelStyle: const TextStyle(
          color: greyColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(
            color: blackColor,
          ),
        ),
        errorBorder: inputBorder,
        suffixIcon: Icon(icon),
        enabledBorder: inputBorder,
        filled: true,
        fillColor: whiteColor,
      ),
    );
  }
}
