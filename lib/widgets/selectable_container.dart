import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class SelectableContainer extends StatelessWidget {
  const SelectableContainer({
    Key? key,
    required this.text,
    required this.onTap,
    required this.borderColor,
    required this.color,
    this.textColor,
  }) : super(key: key);
  final String text;

  final VoidCallback onTap;
  final Color borderColor;
  final Color color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: color,
            borderRadius: BorderRadius.circular(20)),
        child: Text(text, style: AppStyles.s16w400.copyWith(color: textColor)),
      ),
    );
  }
}
