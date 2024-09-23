import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';

class CustomNavigateBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final void Function() navigateBackFunction;

  const CustomNavigateBackButton({
    super.key,
    this.backgroundColor,
    required this.navigateBackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.black.withOpacity(0.3),
      shape: const CircleBorder(),
      child: InkWell(
        splashFactory: InkSparkle.splashFactory,
        splashColor: primaryColor.withOpacity(0.2),
        onTap: navigateBackFunction,
        customBorder: const CircleBorder(),
        child: Ink(
          width: 35.s,
          height: 35.s,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: const Icon(
            Icons.navigate_before,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
