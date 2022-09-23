import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class Heading24 extends StatelessWidget {
  const Heading24({
    Key? key,
    required this.title,
    this.textAlign,
  }) : super(key: key);
  final String title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(title, textAlign: textAlign, style: AppStyles.s24w600);
  }
}
