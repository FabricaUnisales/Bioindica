import 'package:bioindica/src/core/theme/fonts.dart';
import 'package:flutter/material.dart';

class UIText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle style;

  UIText.label(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = labelStyle;
  UIText.label2(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = label2Style;
  UIText.label3(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = label3Style;
  UIText.label4(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = label4Style;
  UIText.label5(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = label5Style;
  UIText.label6(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = label6Style;

  UIText.body(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = bodyStyle;
  UIText.body2(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = body2Style;
  UIText.body3(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = body3Style;
  UIText.body4(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = body4Style;
  UIText.body5(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = body5Style;
  UIText.body6(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = body6Style;

  UIText.textFieldHint(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = textFieldHintStyle;

  UIText.cardTitle(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = cardTitleStyle;
  UIText.cardSubtitle(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = cardSubtitleStyle;
  UIText.cardLabel(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = cardLabelStyle;
  UIText.data(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = dataStyle;
  UIText.dataMajor(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = dataMajorStyle;

  UIText.title(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = titleStyle;
  UIText.subtitle(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = subtitleStyle;

  UIText.boxContent(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = boxContentStyle;
  UIText.confirmButton(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = confirmButtonStyle;
  UIText.cancelButton(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = cancelButtonStyle;

  UIText.snackbarMessage(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = snackbarMessageStyle;
  UIText.settingOption(this.text, {super.key, this.textAlign, this.overflow, this.maxLines}) : style = settingOptionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style,
      maxLines: maxLines,
    );
  }
}
