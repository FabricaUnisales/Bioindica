import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomRadiusImage extends StatelessWidget {
  final Uint8List image;
  final double circularRadius;

  const CustomRadiusImage({super.key, required this.image, this.circularRadius = 5});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circularRadius),
      child: Image.memory(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
