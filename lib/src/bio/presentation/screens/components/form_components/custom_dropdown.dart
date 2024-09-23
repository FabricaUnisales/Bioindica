import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown<T> extends StatelessWidget {
  final Function(dynamic)? onChanged;
  final T initialValue;
  final List<DropdownMenuItem<T>> items;
  final TextStyle? labelTextStyle;
  final String label;
  final Function()? onTap;

  const CustomDropdown({
    super.key,
    required this.onChanged,
    this.labelTextStyle,
    required this.label,
    required this.initialValue,
    required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UIText.label4(label),
        SizedBox(height: 5.s),
        SizedBox(
          height: SizerUtil.height < 600 ? 55.r : null,
          child: DropdownButtonFormField<T>(
            dropdownColor: primaryColor,
            style: textFieldStyle,
            onTap: onTap,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: bodyTextColor, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: bodyTextColor, width: 2.2),
            ),
            constraints: const BoxConstraints(maxHeight: 40),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: failureColor, width: 2.s),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.s),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: failureColor, width: 1.s),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.s),
                ),
              ),
            ),
            onChanged: onChanged,
            value: initialValue,
            items: items,
          ),
        ),
      ],
    );
  }
}
