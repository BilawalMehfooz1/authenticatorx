import 'package:flutter/material.dart';
import 'package:authenticatorx/data/colors.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    this.obsecureText = false,
    required this.icon,
    required this.labelText,
    required this.validator,
    required this.onPressed,
    required this.controller,
    required this.keyboardType,
    required this.isFocusedCallback,
  });

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
  final _inputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: greyColor),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (widget.isFocusedCallback != null) {
        widget.isFocusedCallback!(_isFocused);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Styles
    final style = Theme.of(context);
    final textColor = style.colorScheme.onBackground;
    final brightness = Theme.of(context).brightness == Brightness.dark;
    final fillColor =
        brightness ? const Color.fromARGB(255, 27, 34, 39) : whiteColor;
    const labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    // Main Body
    return TextFormField(
      focusNode: _focusNode,
      cursorColor: textColor,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obsecureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        fillColor: fillColor,
        border: _inputBorder,
        labelStyle: labelStyle,
        labelText: widget.labelText,
        enabledBorder: _inputBorder,
        floatingLabelStyle: TextStyle(color: textColor),
        suffixIconColor: _isFocused ? textColor : greyColor,
        suffixIcon:
            IconButton(onPressed: widget.onPressed, icon: Icon(widget.icon)),
        focusedBorder:
            _inputBorder.copyWith(borderSide: BorderSide(color: textColor)),
        errorBorder: _inputBorder.copyWith(
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}
