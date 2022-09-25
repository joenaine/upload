import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/pages/app_nav_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_styles_const.dart';
import '../../constants/firebase_consts.dart';
import '../../models/grants.dart';
import '../../widgets/app_global_loader_widget.dart';

class UserSubmits extends StatefulWidget {
  const UserSubmits({Key? key}) : super(key: key);

  @override
  State<UserSubmits> createState() => _UserSubmitsState();
}

class _UserSubmitsState extends State<UserSubmits> {
  Future openFile({required String url, String? filename}) async {
    final name = filename ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print(file.path);
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  final user = authInstance.currentUser;
  Widget grantsCard() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("grants")
            .where('userID', isEqualTo: user?.uid)
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
                            "Грантов еще нет",
                            style: AppStyles.s16w400,
                          ),
                          SvgPicture.asset(AppAssets.svg.unselectedAvatar),
                        ],
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        GrantsModel userModelClass = GrantsModel.fromDocument(
                            snapshot.data!.docs[index]);
                        return grantCardList(snapshot, userModelClass);
                      },
                    );
        },
      ),
    );
  }

  Widget grantCardList(
      AsyncSnapshot<QuerySnapshot> snapshot, GrantsModel grantsModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.grey.shade100,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              // changeScreen(
              //     context,
              //     JudgeProjectDetails(
              //         grantsModel: grantsModel,
              //         firstname: firstname,
              //         middlename: middlename,
              //         lastname: lastname));
            },
            child: snapshot.data?.docs.length == null
                ? Container()
                : Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  const Text("Название: ",
                                      style: AppStyles.s16w500),
                                  Text(grantsModel.projectName!,
                                      style: AppStyles.s16w400
                                          .copyWith(color: AppColors.primary)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    'Описание: ',
                                    style: AppStyles.s16w500,
                                  ),
                                  Flexible(
                                    child: Text(grantsModel.desc!,
                                        style: AppStyles.s16w400.copyWith(
                                            color: AppColors.textLight)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    'Документ: ',
                                    style: AppStyles.s16w500,
                                  ),
                                  if (grantsModel.doc != null)
                                    Wrap(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              // UrlL.openUrl(widget.grantsModel!.doc!);
                                              openFile(url: grantsModel.doc!);
                                            },
                                            child: Image.asset(
                                              AppAssets.images.doc,
                                              height: 26,
                                            )),
                                        Flexible(
                                          child: SizedBox(
                                            width: 120,
                                            child: Text(
                                              grantsModel.docName!,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Оценки жюри:',
                                style: AppStyles.s16w500,
                              ),
                              const Divider(
                                color: AppColors.textLight,
                              ),
                              if (grantsModel.estimates!.isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: grantsModel.estimates?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var grant = grantsModel.estimates?[index];
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (grant['judgeName'] != null)
                                          Text(grant['judgeName'] +
                                              ' ' +
                                              grant['judgeLastname'] +
                                              ': '),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Идея: ${grant['ideaR']} '),
                                            Text(
                                                'План по реализации : ${grant['planR']}'),
                                            Text(
                                                'Актуальность: ${grant['actualR']}'),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши заявления'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            grantsCard(),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavBar(current: 3),
    );
  }
}
