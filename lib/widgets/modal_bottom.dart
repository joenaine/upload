import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalBottomSheetCustom {
  static void moreModalBottomSheet(
      context, double height, double horizontal, List<Widget> children) {
    Size size = MediaQuery.of(context).size;
    showMaterialModalBottomSheet(
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Container(
          color: AppColors.white,
          height: height,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.disabledButton,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: horizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FlexibleBottomSheet {
  static void flexBottomSheet(
      context, double height, double horizontal, List<Widget> children) {
    showFlexibleBottomSheet(
      minHeight: .7,
      initHeight: 0.8,
      maxHeight: 0.8,
      context: context,
      builder: (context, ScrollController scrollController,
          double bottomSheetOffset) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              color: AppColors.white,
              // height: height,
              padding: const EdgeInsets.all(16),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.disabledButton,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: horizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  )
                ],
              ));
        });
      },
      isExpand: false,
    );
  }
}
