import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class ToastContainer extends StatelessWidget {
  const ToastContainer({
    Key? key,
    required this.text,
    this.color = AppColors.success,
  }) : super(key: key);
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Text(text,
          style: AppStyles.s16w500.copyWith(color: AppColors.white),
          textAlign: TextAlign.center),
    );
  }
}
