import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';

class CustomCheckboxAndLabel extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final Color activeColor;
  final Color checkColor;
  final Widget label;
  final bool value;
  final bool isWhiteBorder;
  final void Function(bool?) onChanged;

  const CustomCheckboxAndLabel({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.activeColor = secondaryColor,
    this.checkColor = primaryColor,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isWhiteBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: secondaryColor,
          checkColor: primaryColor,
          side: BorderSide(color: isWhiteBorder ? primaryColor : secondaryColor, width: 1.2),
          value: value,
          onChanged: onChanged,
        ),
        label,
      ],
    );
  }
}
