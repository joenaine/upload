import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/pages/app_nav_bar.dart';
import 'package:googleauth/widgets/discolored_button.dart';

import '../../constants/screen_navigation_const.dart';
import 'not_page.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NewsWidgetModel> m = [
      NewsWidgetModel('#IT', 'GovTech vs GameDev Hackathon',
          'Приглашаем на конкурс с целью разработки нового проекта в сфере цифровизации государства или создания игр')
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Новости'),
          actions: [
            IconButton(
                onPressed: () {
                  changeScreen(context, const NotPage());
                },
                icon: SvgPicture.asset(AppAssets.svg.notification))
          ],
        ),
        bottomNavigationBar: const AppNavBar(current: 0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NewsWidget(m: m[0]),
              NewsWidget(m: m[0]),
              NewsWidget(m: m[0]),
              NewsWidget(m: m[0]),
              NewsWidget(m: m[0]),
            ],
          ),
        ));
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key? key,
    this.m,
  }) : super(key: key);
  final NewsWidgetModel? m;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 24,
                    offset: const Offset(0, 10)),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/col1.jpg'),
                      ),
                      Positioned(
                        top: 5,
                        right: 10,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppAssets.svg.calendarblank),
                          label: const Text(
                            '23.09.2022',
                            style: TextStyle(color: Colors.black54),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ))),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m!.hash!,
                          style: AppStyles.s18w600
                              .copyWith(color: AppColors.success),
                        ),
                        Text(m!.title!, style: AppStyles.s16w500),
                        const SizedBox(height: 8),
                        Text(m!.desc!),
                        const SizedBox(height: 16),
                        DiscoloredButton(text: 'Перейти', onPressed: () {})
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsWidgetModel {
  final String? hash;
  final String? title;
  final String? desc;

  NewsWidgetModel(this.hash, this.title, this.desc);
}
