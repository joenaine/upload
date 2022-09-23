import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors_const.dart';

class AppLoaderWidget extends StatelessWidget {
  AppLoaderWidget({
    Key? key,
  }) : super(key: key);
  final isLoading = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 20,
          width: 20,
          child: Platform.isAndroid
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                  backgroundColor: AppColors.white)
              : const CupertinoActivityIndicator()),
    );
  }
}
