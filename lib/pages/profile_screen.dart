// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/pages/profile_settings.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors_const.dart';
import '../constants/app_styles_const.dart';
import '../constants/screen_navigation_const.dart';
import '../widgets/discolored_button.dart';
import '../widgets/modal_bottom.dart';
import '../widgets/profile_stats.dart';
import '../widgets/profile_user_card.dart';
import 'app_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nickname'),
            Text('Редактировать  логин',
                style: AppStyles.s14w400.copyWith(color: AppColors.primary)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                ModalBottomSheetCustom.moreModalBottomSheet(context, 120, 0, [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          changeScreen(context, const ProfileSettings());
                        },
                        child:
                            const Text('Настройки', style: AppStyles.s16w400)),
                  ),
                ]);
              },
              icon: SvgPicture.asset(AppAssets.svg.dotsthree))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              //headerSilverBuilder only accepts slivers
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileUserCard(
                      userId: 1,
                      city: 'Астана',
                      about: 'О себе',
                      name: 'User User'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.white,
                    child: DiscoloredButton(
                        text: 'Редактировать профиль', onPressed: () {}),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Stats(title: 'Отравленных\n заявок:', number: 0),
                        Stats(title: 'Одобренных\nв заявок:', number: 0),
                        Stats(title: 'Неодобренных\n заявок:', number: 0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () async {}, child: const SizedBox());
                },
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.all(16),
                      child: const Text("Игр пока нет",
                          style: AppStyles.s16w500,
                          textAlign: TextAlign.center));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppNavBar(current: 4),
    );
  }
}
