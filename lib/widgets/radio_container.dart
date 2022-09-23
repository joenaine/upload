import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_styles_const.dart';

import '../constants/app_colors_const.dart';

class RadioContainer extends StatelessWidget {
  const RadioContainer(
      {Key? key,
      required this.title,
      required this.children,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.style = AppStyles.s16w500})
      : super(key: key);

  final String title;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      width: double.maxFinite,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: style,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: mainAxisAlignment!,
            children: children,
          )
        ],
      ),
    );
  }
}
