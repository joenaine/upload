import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class SettingItems extends StatelessWidget {
  const SettingItems({
    Key? key,
    required this.icon,
    required this.title,
    this.addText = 'Русский язык',
    this.isBorder = true,
    this.isAddText = false,
  }) : super(key: key);
  final String icon;
  final String title;
  final String? addText;
  final bool? isBorder;
  final bool? isAddText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: (isBorder!)
                  ? const BorderSide(color: AppColors.borders)
                  : BorderSide.none)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 16),
              Text(title, style: AppStyles.s16w400),
            ],
          ),
          Row(
            children: [
              if (isAddText!)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    addText!,
                    style:
                        AppStyles.s16w400.copyWith(color: AppColors.textLight),
                  ),
                ),
              SvgPicture.asset(AppAssets.svg.arrowright)
            ],
          ),
        ],
      ),
    );
  }
}
