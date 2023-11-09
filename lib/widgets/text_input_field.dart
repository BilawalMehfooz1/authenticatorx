import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    this.obsecureText = false,
    required this.icon,
    required this.labelText,
    required this.validator,
    required this.hasError,
    required this.onPressed,
    required this.controller,
    required this.keyboardType,
    required this.isFocusedCallback,
  });

  final bool hasError;
  final IconData? icon;
  final String labelText;
  final bool obsecureText;
  final void Function()? onPressed;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final void Function(bool)? isFocusedCallback;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();
  final inputBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: greyColor),
      borderRadius: BorderRadius.all(Radius.circular(10)));

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      widget.isFocusedCallback!(_isFocused);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      focusNode: _focusNode,
      cursorColor: widget.hasError ? Colors.red : blackColor, // Cursor color
      obscureText: widget.obsecureText,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelStyle: TextStyle(
          color: widget.hasError ? Colors.red : blackColor, // Label color
        ),
        labelStyle: TextStyle(
          color: widget.hasError ? Colors.red : greyColor, // Label color
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: widget.hasError
                ? Colors.red
                : blackColor, // Focused border color
          ),
        ),
        suffixIconColor: _isFocused ? blackColor : greyColor,
        suffixIcon: IconButton(
          onPressed: widget.onPressed,
          icon: Icon(
            widget.icon,
          ), // Icon color
        ),
        enabledBorder: inputBorder,
        filled: true,
        fillColor: whiteColor, // Fill color
      ),
    );
  }
}
