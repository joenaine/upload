import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors_const.dart';

class RatingBarCustom extends StatelessWidget {
  const RatingBarCustom({
    Key? key,
    required this.rating,
    this.itemSize = 18,
    required this.onRatingUpdate,
  }) : super(key: key);

  final double? rating;
  final double? itemSize;
  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        // ignoreGestures: true,
        unratedColor: AppColors.borders,
        itemSize: itemSize!,
        initialRating: rating!,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.only(right: 2.0),
        itemBuilder: (context, _) => SvgPicture.asset(
              AppAssets.svg.star,
              color: AppColors.yellow,
            ),
        onRatingUpdate: onRatingUpdate);
  }
}
