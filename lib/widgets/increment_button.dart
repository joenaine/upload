import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';

class IncrementButton extends StatelessWidget {
  const IncrementButton({
    Key? key,
    required this.onTapPlus,
    required this.onTapMinus,
    this.minusColor = AppColors.disabledButton,
  }) : super(key: key);

  final GestureTapCallback onTapPlus;
  final GestureTapCallback onTapMinus;
  final Color? minusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTapMinus,
            child: SvgPicture.asset(
              AppAssets.svg.minus,
              color: minusColor,
            ),
          ),
          SizedBox(
            height: 24,
            child: VerticalDivider(
              color: Colors.grey.shade100,
              thickness: 1,
              width: 1,
            ),
          ),
          InkWell(
            onTap: onTapPlus,
            child: SvgPicture.asset(
              AppAssets.svg.plus,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
