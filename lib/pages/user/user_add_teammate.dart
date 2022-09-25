import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/widgets/container16.dart';
import 'package:googleauth/widgets/textfields.dart';

import '../../widgets/app_global_loader_widget.dart';

class UserAddTeammate extends StatefulWidget {
  const UserAddTeammate({Key? key}) : super(key: key);

  @override
  State<UserAddTeammate> createState() => _UserAddTeammateState();
}

class _UserAddTeammateState extends State<UserAddTeammate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Добавление игроков'),
        ),
        body: Column(
          children: [
            Container16(
              child: CustomTextField(
                prefixIcon: Row(
                  children: [
                    SvgPicture.asset(AppAssets.svg.search),
                    const SizedBox(width: 10),
                    const Text(
                      'Поиск сокомандников',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  ],
                ),
                hintText: '',
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where('accountType', isEqualTo: 1)
                    //.orderBy('name',descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AppLoaderWidget();
                  }
                  return !snapshot.hasData
                      ? Container()
                      : snapshot.data!.docs.length.toString() == "0"
                          ? SizedBox(
                              height: 250.0,
                              width: 200.0,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  const Text(
                                    "Сборщики сырья еще не зарегистрированы",
                                    style: AppStyles.s16w400,
                                  ),
                                  SvgPicture.asset(
                                      AppAssets.svg.unselectedAvatar),
                                ],
                              ),
                            )
                          : Container16(
                              bottom: 16,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var user = snapshot.data!.docs[index];
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.svg.unselectedAvatar,
                                            height: 50,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(user['firstname'] +
                                              ' ' +
                                              user['lastname']),
                                          const Spacer(),
                                          SvgPicture.asset(
                                              AppAssets.svg.checkboxInactive)
                                        ],
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                              ),
                            );
                })
          ],
        ));
  }
}
