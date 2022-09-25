import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/pages/settings/faq_screen.dart';
import 'package:googleauth/pages/settings/notification/notification_set_screen.dart';
import 'package:googleauth/pages/settings/protection/protection.dart';
import 'package:googleauth/pages/settings/public_offer_screen.dart';
import 'package:googleauth/pages/settings/support/support_screen.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors_const.dart';
import '../constants/app_styles_const.dart';
import '../constants/firebase_consts.dart';
import '../constants/screen_navigation_const.dart';
import '../widgets/settings_items.dart';
import 'login_screen.dart';
import 'settings/language_screen.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> setItemList = [
      [AppAssets.svg.shield, 'Безопасность', const Protection()],
      [AppAssets.svg.notif, 'Уведомления', const NotificationSet()],
      [AppAssets.svg.oferta, 'Публичная оферта', const PublicOfferScreen()],
      [AppAssets.svg.support, 'Написать в техподдержку', const SupportScreen()],
      [AppAssets.svg.faq, 'Вопросы и ответы', const FaqScreen()],
      [AppAssets.svg.mappin, 'Язык', const LanguageScreen()],
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.svg.arrowleft)),
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: setItemList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: SettingItems(
                  icon: setItemList[index][0],
                  title: setItemList[index][1],
                  isBorder: index != setItemList.length - 1,
                  isAddText: index == setItemList.length - 1,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () async {
                await authInstance.signOut();
                changeScreenByRemove(context, const Login(), "/login");
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Выйти',
                  style: AppStyles.s16w400.copyWith(color: AppColors.textLight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
