// ignore_for_file: depend_on_referenced_packages, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/pages/profile_screen.dart';
import 'package:googleauth/pages/user/user_screen.dart';
import 'package:googleauth/pages/user/user_team.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors_const.dart';
import '../constants/app_styles_const.dart';
import 'user/user_home.dart';
import 'user/user_submits.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({Key? key, required this.current}) : super(key: key);

  final int current;

  PageRouteBuilder _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: current,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey.shade300,
      backgroundColor: AppColors.white,
      selectedFontSize: 10.0,
      unselectedFontSize: 10.0,
      items: [
        BottomNavigationBarItem(
            icon: Column(
              children: [
                SvgPicture.asset(AppAssets.svg.house,
                    color: current == 0
                        ? AppColors.primary
                        : Colors.grey.shade300),
                Text('Главная',
                    style: AppStyles.s10w400.copyWith(
                        color: current == 0
                            ? AppColors.primary
                            : Colors.grey.shade300))
              ],
            ),
            label: 'Главная'),
        BottomNavigationBarItem(
            icon: Column(
              children: [
                SvgPicture.asset(AppAssets.svg.handshake,
                    color: current == 1
                        ? AppColors.primary
                        : Colors.grey.shade300),
                Text('Команда',
                    style: AppStyles.s10w400.copyWith(
                        color: current == 1
                            ? AppColors.primary
                            : Colors.grey.shade300))
              ],
            ),
            label: 'Команда'),
        BottomNavigationBarItem(
            icon: Column(
              children: [
                SvgPicture.asset(AppAssets.svg.pluscircle),
                Text('Создать заявку',
                    style: AppStyles.s10w400.copyWith(color: AppColors.primary))
              ],
            ),
            label: 'Создать заявку'),
        BottomNavigationBarItem(
            icon: Column(
              children: [
                SvgPicture.asset(AppAssets.svg.oferta,
                    color: current == 3
                        ? AppColors.primary
                        : Colors.grey.shade300),
                Text('Проекты',
                    style: AppStyles.s10w400.copyWith(
                        color: current == 3
                            ? AppColors.primary
                            : Colors.grey.shade300))
              ],
            ),
            label: 'Игроки'),
        BottomNavigationBarItem(
            icon: Column(
              children: [
                SvgPicture.asset(AppAssets.svg.profile,
                    height: 24,
                    width: 24,
                    color: current == 4
                        ? AppColors.primary
                        : Colors.grey.shade300),
                Text('Профиль',
                    style: AppStyles.s10w400.copyWith(
                        color: current == 4
                            ? AppColors.primary
                            : Colors.grey.shade300))
              ],
            ),
            label: 'Профиль'),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const UserHome()), (route) => false);
        } else if (index == 1) {
          Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const UserTeam()), (route) => false);
        } else if (index == 2) {
          Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const UserScreen()), (route) => false);
        } else if (index == 3) {
          Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const UserSubmits()), (route) => false);
        } else if (index == 4) {
          Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const ProfilePage()), (route) => false);
        }
      },
    );
  }
}
