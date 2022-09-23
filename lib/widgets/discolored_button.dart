import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

class DiscoloredButton extends StatelessWidget {
  const DiscoloredButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: AppColors.primary)),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: AppStyles.s16w500.copyWith(color: AppColors.primary),
      ),
    );
  }
}
