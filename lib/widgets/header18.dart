import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
    required this.text,
    this.textAlign,
    this.lineHeight,
  }) : super(key: key);
  final String text;
  final TextAlign? textAlign;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.s18w600.copyWith(height: lineHeight),
      textAlign: textAlign,
    );
  }
}
