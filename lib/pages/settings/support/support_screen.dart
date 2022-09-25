import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors_const.dart';
import '../../../constants/app_styles_const.dart';

import '../../../widgets/container16.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/textfields.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController controller = TextEditingController();
  int count = 0;
  bool isActive = false;
  late FToast fToast;
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
        title: const Text('Написать в техподдержку'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.svg.arrowleft)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            color: AppColors.white,
            width: double.infinity,
            child: const Text(
                'Если у вас появились какие-либо\nвопросы, можете написать нам',
                style: AppStyles.s16w400,
                textAlign: TextAlign.center),
          ),
          Container16(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      count = value.length;
                      isActive = true;
                      if (value.isEmpty) isActive = false;
                    });
                  },
                  bottom: 4,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(160),
                  ],
                  maxlines: null,
                  keyboardType: TextInputType.multiline,
                  hintText: 'Введите сообщение',
                ),
                Text(
                  '$count/160',
                  style: AppStyles.s12w400.copyWith(color: AppColors.textLight),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const Spacer(),
          Container16(
            bottom: 16,
            child: GeneralButton(
                isLoading: isLoading,
                text: 'Отправить',
                onPressed: () async {},
                color: isActive ? AppColors.primary : AppColors.disabledButton),
          )
        ],
      ),
    );
  }
}
