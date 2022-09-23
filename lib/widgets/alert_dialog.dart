import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/widgets/general_button.dart';

import 'discolored_button.dart';

class AlertDialogCustom {
  static void customAlert(
    context,
    String title,
    String? content,
    String generalButton,
    String? discoloredButton,
    VoidCallback onTapGeneral,
    VoidCallback onTapDiscoloured,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            contentTextStyle:
                AppStyles.s16w400.copyWith(color: AppColors.textLight),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.s18w600,
            ),
            content: content != null
                ? Text(
                    content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  )
                : null,
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            actions: [
              GeneralButton(text: generalButton, onPressed: onTapGeneral
                  // () async {
                  // Fluttertoast.showToast(
                  //   msg: "your message",
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.BOTTOM,
                  // );
                  // },
                  ),
              const SizedBox(height: 10),
              if (discoloredButton != null)
                DiscoloredButton(
                    text: discoloredButton, onPressed: onTapDiscoloured)
            ],
          );
        });
  }
}
