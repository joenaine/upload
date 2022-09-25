import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors_const.dart';
import '../../../widgets/container16.dart';
import '../../../constants/app_styles_const.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/textfields.dart';

class ProtectionPassword extends StatefulWidget {
  const ProtectionPassword({Key? key}) : super(key: key);

  @override
  State<ProtectionPassword> createState() => _ProtectionPasswordState();
}

class _ProtectionPasswordState extends State<ProtectionPassword> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  bool onLength1 = false;
  bool onLength2 = false;
  final formkey = GlobalKey<FormState>();
  String old_password = '';
  String new_password = '';
  String confirm_password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.svg.arrowleft)),
        title: const Text('Пароль'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Container16(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Пароль должен сожержать не менее 8 символов',
                    style:
                        AppStyles.s12w400.copyWith(color: AppColors.textLight),
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    key: const Key('oldpsw'),
                    validator: (value) {
                      (value!.length < 8)
                          ? 'Пароль должен сожержать не менее 8 символов'
                          : null;
                      return null;
                    },
                    onSaved: (value) {
                      old_password = value!;
                    },
                    hintText: 'Текущий пароль',
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    onSaved: (value) {
                      new_password = value!;
                    },
                    validator: (value) {
                      (value!.length < 8)
                          ? 'Пароль должен сожержать не менее 8 символов'
                          : null;
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        onLength1 = value.length > 7;
                      });
                    },
                    hintText: 'Новый пароль',
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    onSaved: (value) {
                      confirm_password = value!;
                    },
                    validator: (value) {
                      (value!.length < 8)
                          ? 'Пароль должен сожержать не менее 8 символов'
                          : null;
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        onLength2 = value.length > 7;
                      });
                    },
                    hintText: 'Введите пароль еще раз',
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Забыли пароль?',
                        style: AppStyles.s16w400
                            .copyWith(color: AppColors.primary),
                      ))
                ],
              ),
            ),
            const Spacer(),
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16),
              child: GeneralButton(
                color: (onLength1 && onLength2)
                    ? AppColors.primary
                    : AppColors.disabledButton,
                text: 'Сохранить',
                onPressed: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
