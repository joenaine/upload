import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/pages/login_screen.dart';
import 'package:googleauth/widgets/general_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .12),
            SvgPicture.asset(AppAssets.svg.success),
            const SizedBox(height: 20),
            const Text('Поздравляем!', style: AppStyles.s24w600),
            const SizedBox(height: 4),
            Text('Регистрация прошла успешно',
                style: AppStyles.s16w400.copyWith(color: AppColors.textLight)),
            const SizedBox(height: 40),
            SizedBox(
              width: 140,
              child: GeneralButton(
                  text: 'На главную',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                        ModalRoute.withName("/login"));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
