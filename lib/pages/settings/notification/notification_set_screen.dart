import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors_const.dart';
import '../../../constants/app_styles_const.dart';

class NotificationSet extends StatefulWidget {
  const NotificationSet({Key? key}) : super(key: key);

  @override
  State<NotificationSet> createState() => _NotificationSetState();
}

class _NotificationSetState extends State<NotificationSet> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Уведомления'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.svg.arrowleft)),
      ),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Показывать в профиле',
              style: AppStyles.s16w400,
            ),
            Expanded(
              child: ListTileSwitch(
                contentPadding: EdgeInsets.zero,
                value: true,
                onChanged: (value) async {},
                visualDensity: VisualDensity.comfortable,
                switchType: SwitchType.cupertino,
                switchActiveColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
