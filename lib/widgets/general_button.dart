import 'package:flutter/material.dart';

import '../constants/app_colors_const.dart';
import '../constants/app_styles_const.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color = AppColors.primary,
      this.isLoading = false})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      minWidth: double.infinity,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: (isLoading!)
          ? const SizedBox(
              height: 21,
              width: 21,
              child: CircularProgressIndicator(
                  strokeWidth: 3, color: AppColors.white))
          : Text(text,
              style: AppStyles.s16w500.copyWith(color: AppColors.white)),
    );
  }
}
