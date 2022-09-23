import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class TextCheck extends StatelessWidget {
  const TextCheck({
    Key? key,
    required this.text,
    this.isSelected = false,
    this.isBorderNeed = true,
    this.onTap,
    this.checkBox = const SizedBox(),
  }) : super(key: key);

  final String text;

  final bool? isSelected;
  final bool? isBorderNeed;
  final VoidCallback? onTap;
  final Widget? checkBox;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
            border: Border(
                bottom: (isBorderNeed!)
                    ? const BorderSide(color: AppColors.borders)
                    : BorderSide.none)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppStyles.s16w400,
            ),
            checkBox!
          ],
        ),
      ),
    );
  }
}
