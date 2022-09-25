import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors_const.dart';
import '../../constants/app_styles_const.dart';
import '../../widgets/heading24.dart';

class NotPage extends StatefulWidget {
  const NotPage({Key? key}) : super(key: key);

  @override
  State<NotPage> createState() => _NotPageState();
}

class _NotPageState extends State<NotPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(AppAssets.svg.arrowleft)),
          title: const Text('Уведомления'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                splashFactory: NoSplash.splashFactory,
                isScrollable: true,
                automaticIndicatorColorAdjustment: true,
                labelStyle: AppStyles.s16w500,
                labelColor: AppColors.dark,
                unselectedLabelColor: AppColors.textLight,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(text: 'Уведомления'),
                  Tab(text: 'Сообщения'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.svg.bell),
              const SizedBox(height: 20),
              const Heading24(title: 'Уведомлений пока нет'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.svg.message),
              const SizedBox(height: 20),
              const Heading24(title: 'Cообщений пока нет'),
            ],
          ),
        ]),
      ),
    );
  }
}
