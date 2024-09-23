import 'package:bioindica/src/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: secondaryColor.withOpacity(0.9),
      showChildOpacityTransition: false,
      springAnimationDurationInMilliseconds: 300,
      onRefresh: onRefresh,
      child: child,
    );
  }
}