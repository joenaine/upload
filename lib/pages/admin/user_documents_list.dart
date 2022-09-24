import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/models/grants.dart';
import 'package:googleauth/widgets/app_global_loader_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_assets.dart';

class UserDocumentsList extends StatefulWidget {
  const UserDocumentsList({Key? key, this.userId}) : super(key: key);
  final String? userId;

  @override
  State<UserDocumentsList> createState() => _UserDocumentsListState();
}

class _UserDocumentsListState extends State<UserDocumentsList> {
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

  _trashPickersList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("grants")
            .where('userID', isEqualTo: widget.userId)
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
                            "Нет документов",
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
                        return trashPickersDetailsCard(
                            snapshot, userModelClass);
                      },
                    );
        },
      ),
    );
  }

  Widget trashPickersDetailsCard(
      AsyncSnapshot<QuerySnapshot> snapshot, GrantsModel grant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.grey.shade100,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
            child: snapshot.data?.docs.length == null
                ? Container()
                : Wrap(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          // changeScreen(context, const UserDocumentsList());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(grant.projectName!, style: AppStyles.s14w400),
                            const SizedBox(height: 5.0),
                            InkWell(
                                onTap: () {
                                  // UrlL.openUrl(widget.grantsModel!.doc!);
                                  openFile(url: grant.doc!);
                                },
                                child: Image.asset(
                                  AppAssets.images.doc,
                                  height: 86,
                                )),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: grant.estimates?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = grant.estimates?[index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('${item['judgeName']}     '),
                                    Text(item['ideaR'].toString()),
                                    const SizedBox(width: 20),
                                    Text(item['actualR'].toString()),
                                    Text(item['planR'].toString()),
                                  ],
                                );
                              },
                            ),
                          ],
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
      appBar: AppBar(),
      body: _trashPickersList(),
    );
  }
}
