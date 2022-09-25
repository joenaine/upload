import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors_const.dart';
import '../constants/app_styles_const.dart';
import 'general_button.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({
    Key? key,
    this.title,
    this.avatar,
    this.about,
    this.desc,
    this.rating = 0.0,
    this.city,
    this.passion,
    this.socials,
    required this.name,
    this.reviewsAmount = 0,
    this.isVerified = false,
    this.userId,
  }) : super(key: key);
  final String? title;
  final String? avatar;
  final String? about;
  final String? desc;
  final double? rating;
  final String? city;
  final String? passion;
  final int? userId;

  final List<Widget>? socials;
  final String name;
  final int? reviewsAmount;
  final bool? isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          Row(
            children: [
              if (avatar != null)
                CircleAvatar(radius: 40, backgroundImage: AssetImage(avatar!)),
              if (avatar == null)
                Container(
                    width: 40,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: SvgPicture.asset(AppAssets.svg.profile)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (isVerified!) {
                          showVerificationInfoDialog(context);
                        }
                      },
                      child: Row(
                        children: [
                          Text(name, style: AppStyles.s16w500),
                          const SizedBox(width: 5),
                          if (isVerified!)
                            SvgPicture.asset(AppAssets.svg.verificationLogo,
                                width: 20),
                        ],
                      )),
                  const SizedBox(height: 8),
                  TextButton(
                      onPressed: () {
                        // if (about == null) {
                        //   changeScreen(context, const ProfileEdit());
                        // }
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(40, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft),
                      child: Text(about ?? 'О себе',
                          style: AppStyles.s12w400.copyWith(
                              color: about != 'О себе'
                                  ? AppColors.textLight
                                  : AppColors.primary))),
                  const SizedBox(height: 5),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.svg.mappin,
                height: 16,
              ),
              const SizedBox(width: 4),
              Text(
                city ?? 'Город',
                style: TextStyle(
                    color:
                        city != null ? AppColors.textLight : AppColors.primary),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppAssets.svg.thumbsup,
                height: 16,
              ),
              const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 16),
          Row(children: socials ?? [])
        ],
      ),
    );
  }
}

void showVerificationInfoDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            titlePadding: const EdgeInsets.all(8),
            title: Column(
              children: [
                SvgPicture.asset(AppAssets.svg.verificationLogo, width: 80),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Ваш профиль верифицирован',
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            content: GeneralButton(text: 'Назад', onPressed: () {}),
          ));
}

class RatingBarCustom extends StatelessWidget {
  const RatingBarCustom({
    Key? key,
    required this.rating,
    this.itemSize = 18,
  }) : super(key: key);

  final double? rating;
  final double? itemSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: true,
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
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
