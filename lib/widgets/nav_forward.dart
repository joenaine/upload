import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/app_assets.dart';

class NavForward extends StatelessWidget {
  const NavForward({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppAssets.svg.arrowright);
  }
}
