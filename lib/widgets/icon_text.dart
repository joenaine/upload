import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.icon,
    required this.text,
    this.style,
  }) : super(key: key);
  final String icon;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 4),
        Text(text,
            style: style ??
                AppStyles.s14w400.copyWith(
                  color: AppColors.textLight,
                ))
      ],
    );
  }
}
