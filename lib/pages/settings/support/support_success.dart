import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors_const.dart';
import '../../../widgets/discolored_button.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/heading24.dart';

class SupportSuccess extends StatelessWidget {
  const SupportSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.svg.message),
              const SizedBox(height: 20),
              const Heading24(title: 'Сообщение отправлено'),
              const SizedBox(height: 4),
              const Text('Ответ на ваше сообщение поступит в уведомлении',
                  style: TextStyle(color: AppColors.textLight, height: 1.5),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),
              SizedBox(
                  width: 220,
                  child: GeneralButton(
                      text: 'Перейти в настройки', onPressed: () {})),
              const SizedBox(height: 10),
              SizedBox(
                  width: 220,
                  child: DiscoloredButton(
                      text: 'Перейти на Главную', onPressed: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
