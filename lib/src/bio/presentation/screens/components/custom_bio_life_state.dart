import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';

class CustomBioLifeState extends StatelessWidget {
  final String bioLifeState;

  const CustomBioLifeState({super.key, required this.bioLifeState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: UIText.body3('Estado: $bioLifeState'),
    );
  }
}
