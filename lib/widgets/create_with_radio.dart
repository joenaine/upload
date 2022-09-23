import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class CreateWithRadio extends StatelessWidget {
  const CreateWithRadio({
    Key? key,
    required this.title,
    required this.children,
    this.space = 16,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final double? space;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.maxFinite,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.s16w500,
          ),
          SizedBox(height: space!),
          Column(
            children: children,
          )
        ],
      ),
    );
  }
}
