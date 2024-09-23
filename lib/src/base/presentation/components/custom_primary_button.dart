import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final bool isALternative;
  final String titleText;
  final VoidCallback? onPressed;

  const CustomPrimaryButton({
    super.key,
    this.isALternative = false,
    required this.titleText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: const BorderSide(
            color: secondaryColor,
            width: 1,
          ),
        backgroundColor: isALternative ? primaryColor : secondaryColor,
      ),
      onPressed: onPressed,
      child: Text(
        titleText,
        style: isALternative ? label2AlternativeStyle : label2Style,
      ),
    );
  }
}
