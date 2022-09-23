import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';

class Container16 extends StatelessWidget {
  const Container16({
    Key? key,
    this.child,
    this.bottom = 0,
  }) : super(key: key);
  final Widget? child;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottom!),
      color: AppColors.white,
      child: child,
    );
  }
}
