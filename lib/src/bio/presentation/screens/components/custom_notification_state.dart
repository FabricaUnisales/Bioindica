import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

///Classe responsável por renderizar um widget de notificação de estado/falha
class CustomNotificationState extends StatelessWidget {
  final String? asset;
  final String title;
  final String? subtitle;
  final double assetSize;
  final bool isLottie;

  const CustomNotificationState({
    super.key,
    this.assetSize = 4,
    this.asset,
    required this.title,
    this.subtitle,
    this.isLottie = false,
  });

  @override
  Widget build(BuildContext context) {
    return UIPadding(
      useHorizontalPadding: true,
      useVerticalPadding: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          asset != null ? _buildImage(context) : const SizedBox(),
          UIText.title(title, textAlign: TextAlign.center),
          SizedBox(height: 6.s),
          subtitle != null
              ? UIText.subtitle(subtitle!, textAlign: TextAlign.center)
              : const SizedBox(),
        ],
      ),
    );
  }

  ///Método para renderizar a imagem da notificação caso a orientação seja modo retrato
  Widget _buildImage(BuildContext context) {
    return SizerUtil.orientation == Orientation.portrait
        ? Column(
            children: [
              isLottie ? Lottie.asset(asset!, width: 245.s, repeat: false) : SvgPicture.asset(
                asset!,
                height: Theme.of(context).rowSize * assetSize,
              ),
              SizedBox(height: 12.0.s),
            ],
          )
        : Column(
            children: [
              isLottie ? Lottie.asset(asset!, width: 130.s3, repeat: false) : SvgPicture.asset(
                asset!,
                height: Theme.of(context).rowSize * assetSize,
              ),
              isLottie ? const SizedBox() : SizedBox(height: 12.0.s),
            ],
          );
  }
}
