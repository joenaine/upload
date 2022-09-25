import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants/app_colors_const.dart';
import '../../../constants/app_regex_const.dart';
import '../../../constants/app_styles_const.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../widgets/alert_dialog.dart';
import '../../../widgets/container16.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/nav_back.dart';
import '../../../widgets/textfields.dart';
import '../../../widgets/toast.dart';

class ProtectionNumber extends StatefulWidget {
  const ProtectionNumber({Key? key}) : super(key: key);

  @override
  State<ProtectionNumber> createState() => _ProtectionNumberState();
}

class _ProtectionNumberState extends State<ProtectionNumber> {
  late FToast fToast;
  late MaskTextInputFormatter _phoneMaskController;

  @override
  void initState() {
    super.initState();
    _phoneMaskController = MaskTextInputFormatter(
        mask: AppRegexPattern.phoneKZ,
        filter: {"#": AppRegexPattern.digitRegex});
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NavBack(),
        title: const Text('Номер телефона'),
      ),
      body: Column(
        children: [
          Container16(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Текущий номер телефона: +7 777 345 65 65',
                  style: AppStyles.s12w400.copyWith(color: AppColors.textLight),
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  hintText: 'Новый номер телефона',
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(16),
            child: GeneralButton(
              color: AppColors.primary,
              text: 'Сохранить',
              onPressed: () async {
                AlertDialogCustom.customAlert(
                    context,
                    'Сообщение отправлено',
                    'На вашу почту baur@gmail.com отправлено письмо с паролем',
                    'Ок',
                    null, () {
                  Navigator.pop(context);
                  fToast.showToast(
                    child: const ToastContainer(text: "Номер успешно изменен"),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );
                }, () {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
