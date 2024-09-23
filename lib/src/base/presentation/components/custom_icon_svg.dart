// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconSVG extends StatelessWidget {
  final String svgIconPath;
  final VoidCallback? onTap;
  final bool isSelected;

  const CustomIconSVG({
    super.key,
    required this.svgIconPath,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          svgIconPath,
          colorFilter: isSelected ? const ColorFilter.mode(secondaryColor, BlendMode.srcIn) : null,
          width: 20.s,
        ),
      ),
    );
  }
}
