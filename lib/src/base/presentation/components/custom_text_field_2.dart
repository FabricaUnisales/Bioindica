import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class CustomTextField2 extends StatelessWidget {
  final bool? enabled;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isSVGSuffixIcon;
  final String? svgSuffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onFieldSubmitted;
  final bool enableButtonCleanValue;
  final VoidCallback? onPressedSuffixIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;

  const CustomTextField2({
    super.key,
    this.enabled,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.isSVGSuffixIcon = false,
    this.controller,
    this.validatorFunction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.enableButtonCleanValue = false,
    this.onPressedSuffixIcon,
    this.focusNode,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType,
    this.hintText,
    this.svgSuffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: UIText.label4(labelText),
        ),
        const SizedBox(height: 5),
        TextFormField(
          enabled: enabled,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          controller: controller,
          cursorColor: secondaryColor,
          style: textFieldStyle,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textFieldHintStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: _buildDefaultBorder(), 
            disabledBorder: _buildDefaultBorder(),
            focusedBorder: _buildDefaultBorder(borderWidth: 2.2),
            // constraints: maxLines > 1 ? null : const BoxConstraints(maxHeight: 35),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: _buildSuffixIcon(),
          ),
          validator: validatorFunction,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
  
  Widget? _buildSuffixIcon() {
    if (suffixIcon != null) {
      return isSVGSuffixIcon && svgSuffixIcon != null ? SvgPicture.asset(svgSuffixIcon!, fit: BoxFit.none) : IconButton(
        onPressed: onPressedSuffixIcon,
        icon: Icon(suffixIcon, color: bodyTextColor),
      );
    }

    return null;
  }

  OutlineInputBorder _buildDefaultBorder({double borderWidth = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: bodyTextColor, width: borderWidth),
    );
  }
}
