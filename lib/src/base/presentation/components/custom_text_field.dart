// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bioindica/src/core/theme/colors.dart';

class CustomTextField extends StatefulWidget {
  final bool? isDisabled;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onFieldSubmitted;
  final bool enableButtonCleanValue;
  final VoidCallback? onPressedSuffixIcon;
  final FocusNode? focusNode;
  final bool isPassword;
  final bool autofocus;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.isDisabled,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validatorFunction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.enableButtonCleanValue = false,
    this.onPressedSuffixIcon,
    this.focusNode,
    this.isPassword = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
  });


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: widget.controller,
      cursorColor: secondaryColor,
      obscureText: _obscureText,
      decoration: InputDecoration(
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: failureColor),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: failureColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: primaryColor),
        suffixIcon:
            widget.isPassword
                ? GestureDetector(
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: secondaryColor,
                    ),
                    onTap: () => setState(() => _obscureText = !_obscureText),
                  )
                : widget.enableButtonCleanValue
                    ? GestureDetector(
                        child: const Icon(
                          Icons.clear,
                          color: secondaryColor,
                        ),
                        onTap: () {
                          widget.controller!.clear();
                        },
                      )
                    : GestureDetector(
                        onTap: widget.onPressedSuffixIcon,
                        child: Icon(
                          widget.suffixIcon,
                          color: secondaryColor,
                        ),
                      ),
      ),
      style: const TextStyle(color: primaryColor),
      validator: widget.validatorFunction,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
    );
  }
}
