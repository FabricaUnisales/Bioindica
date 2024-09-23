import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

///Cria um padding para o widget, seguindo a regra do aplicativo
class UIPadding extends StatelessWidget {
  final Widget? child;
  final bool useHorizontalPadding;
  final bool useVerticalPadding;

  const UIPadding({
    super.key,
    required this.child,
    this.useHorizontalPadding = false,
    this.useVerticalPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: useHorizontalPadding ? (SizerUtil.orientation == Orientation.portrait ? Theme.of(context).columnSize * 0.5 : Theme.of(context).columnSize * 1.5) : 0,
        vertical: useVerticalPadding ? Theme.of(context).rowSize * 0.3 : 0,
      ),
      child: child,
    );
  }
}

///Cria um padding para o sliver, seguindo a regra do aplicativo
// ignore: must_be_immutable
class UISliverPadding extends SliverPadding {
  BuildContext context;

  @override
  UISliverPadding({
    super.key,
    required Widget child,
    bool useHorizontalPadding = false,
    bool useVerticalPadding = false,
    required this.context,
  }) : super(
          sliver: child,
          padding: EdgeInsets.symmetric(
            horizontal: useHorizontalPadding ? (SizerUtil.orientation == Orientation.portrait ? Theme.of(context).columnSize * 0.5 : Theme.of(context).columnSize * 1.5) : 0,
            vertical: useVerticalPadding ? Theme.of(context).rowSize * 0.3 : 0,
          ),
        );
}
