import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/app_assets.dart';

class UploadWidget extends StatelessWidget {
  const UploadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {}, icon: SvgPicture.asset(AppAssets.svg.uploadSimple));
  }
}
