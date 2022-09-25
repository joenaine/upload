import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants/app_colors_const.dart';
import '../../../constants/app_styles_const.dart';

import '../../../widgets/container16.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/nav_back.dart';
import '../../../widgets/textfields.dart';

class ProtectionEmail extends StatefulWidget {
  const ProtectionEmail({Key? key}) : super(key: key);

  @override
  State<ProtectionEmail> createState() => _ProtectionEmailState();
}

class _ProtectionEmailState extends State<ProtectionEmail> {
  TextEditingController controller = TextEditingController();
  late FToast fToast;
  bool isActive = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NavBack(),
        title: const Text('E-mail'),
      ),
      body: Column(
        children: [
          Container16(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Текущий e-mail: user@gmail.com',
                  style: AppStyles.s12w400.copyWith(color: AppColors.textLight),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Новый E-mail',
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      isActive = true;
                      if (value.isEmpty) isActive = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(16),
            child: GeneralButton(
              isLoading: isLoading,
              color: isActive ? AppColors.primary : AppColors.disabledButton,
              text: 'Сохранить',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
