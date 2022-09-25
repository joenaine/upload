import 'package:flutter/material.dart';
import 'package:googleauth/pages/settings/protection/protection_number.dart';
import 'package:googleauth/pages/settings/protection/protection_pass.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors_const.dart';

import '../../../widgets/nav_back.dart';
import '../../../widgets/settings_items.dart';
import 'protection_email.dart';

class Protection extends StatelessWidget {
  const Protection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> setItemList = [
      [AppAssets.svg.email, 'E-mail', const ProtectionEmail()],
      [AppAssets.svg.phone, 'Номер телефона', const ProtectionNumber()],
      [AppAssets.svg.password, 'Пароль', const ProtectionPassword()],
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          elevation: 0.5,
          leading: const NavBack(),
          title: const Text('Безопасность')),
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
                    isBorder: index != setItemList.length - 1),
              );
            },
          ),
        ],
      ),
    );
  }
}
