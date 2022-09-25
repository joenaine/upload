import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/pages/app_nav_bar.dart';
import 'package:googleauth/pages/user/user_add_teammate.dart';
import 'package:googleauth/widgets/container16.dart';
import 'package:googleauth/widgets/discolored_button.dart';
import 'package:googleauth/widgets/filter_container.dart';
import 'package:googleauth/widgets/general_button.dart';
import 'package:googleauth/widgets/textfields.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors_const.dart';
import '../../constants/screen_navigation_const.dart';
import 'not_page.dart';

class UserTeam extends StatelessWidget {
  const UserTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppNavBar(current: 1),
      bottomSheet: Container16(
        bottom: 16,
        child: GeneralButton(
          text: 'Создать команду',
          onPressed: () {},
          color: AppColors.disabledButton,
        ),
      ),
      appBar: AppBar(
        title: const Text('Создание команды'),
      ),
      body: Column(
        children: [
          const Container16(
            child: CustomTextField(
              hintText: 'Название команды',
            ),
          ),
          const SizedBox(height: 8),
          FilterContainers(title: 'Состав команды', children: [
            Expanded(
                child: DiscoloredButton(
                    text: '+ Добавьте пользователя',
                    onPressed: () {
                      changeScreen(context, const UserAddTeammate());
                    }))
          ]),
          const SizedBox(height: 8),
          FilterContainers(
              mainAxisAlignment: MainAxisAlignment.center,
              title: 'Загрузите логотип команды',
              children: [
                Stack(
                  children: [
                    Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: AppColors.disabledButton,
                            borderRadius: BorderRadius.circular(100)),
                        child: SvgPicture.asset(AppAssets.svg.profile,
                            color: Colors.white)),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          offset: Offset(0, 0),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(Icons.camera_alt_outlined))))
                  ],
                )
              ])
        ],
      ),
    );
  }
}
