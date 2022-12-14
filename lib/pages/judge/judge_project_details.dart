import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/models/estimate.dart';
import 'package:googleauth/models/grants.dart';
import 'package:googleauth/widgets/general_button.dart';
import 'package:googleauth/widgets/rating_bar_custom.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_colors_const.dart';
import '../../constants/firebase_consts.dart';
import '../../widgets/toast.dart';

class JudgeProjectDetails extends StatefulWidget {
  const JudgeProjectDetails(
      {Key? key,
      this.grantsModel,
      this.firstname,
      this.middlename,
      this.lastname})
      : super(key: key);
  final GrantsModel? grantsModel;
  final String? firstname;
  final String? middlename;
  final String? lastname;

  @override
  State<JudgeProjectDetails> createState() => _JudgeProjectDetailsState();
}

class _JudgeProjectDetailsState extends State<JudgeProjectDetails> {
  bool isLoading = false;
  late FToast fToast;
  Future openFile({required String url, String? filename}) async {
    final name = filename ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print(file.path);
    OpenFile.open(file.path);
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  double ratingIdea = 0;
  double ratingPlan = 0;
  double ratingActual = 0;
  final user = authInstance.currentUser;
  final String userProfileID =
      FirebaseAuth.instance.currentUser!.uid.toString();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> addPostToListOfGrants(EstimateModel e) async {
    firestoreInstance
        .collection('grants')
        .doc(widget.grantsModel?.docID)
        .update({
      'estimates': FieldValue.arrayUnion([
        {
          'actualR': ratingActual,
          'ideaR': ratingIdea,
          'planR': ratingPlan,
          'judgeID': userProfileID,
          'judgeName': widget.firstname,
          'judgeMiddlename': widget.middlename,
          'judgeLastname': widget.lastname,
          'estimates': []
        }
      ])
    }).then(
      (value) {
        setState(() {
          isLoading = false;
        });
        fToast.showToast(
          child: const ToastContainer(text: "?????????????? ????????????????????"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      },
    ).catchError(
      (error) {
        setState(() {
          isLoading = false;
        });
        fToast.showToast(
          child: const ToastContainer(
              text: "?????????????????? ????????????", color: AppColors.error),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.grantsModel!.projectName!),
        ),
        body: Column(
          children: [
            if (widget.grantsModel?.doc != null)
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        // UrlL.openUrl(widget.grantsModel!.doc!);
                        openFile(url: widget.grantsModel!.doc!);
                      },
                      child: Image.asset(
                        AppAssets.images.doc,
                        height: 86,
                      )),
                  Text(widget.grantsModel!.desc!),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('????????'),
                RatingBarCustom(
                    rating: ratingIdea,
                    onRatingUpdate: (value) {
                      setState(() {
                        ratingIdea = value;
                      });
                    }),
                Text(ratingIdea.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('???????? ???? ???????????????????? '),
                RatingBarCustom(
                    rating: ratingPlan,
                    onRatingUpdate: (value) {
                      setState(() {
                        ratingPlan = value;
                      });
                    }),
                Text(ratingPlan.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('????????????????????????'),
                RatingBarCustom(
                    rating: ratingActual,
                    onRatingUpdate: (value) {
                      setState(() {
                        ratingActual = value;
                      });
                    }),
                Text(ratingActual.toString()),
              ],
            ),
            GeneralButton(
                text: '?????????????????? ????????????',
                onPressed: () {
                  EstimateModel e = EstimateModel(
                    actualR: ratingActual,
                    ideaR: ratingIdea,
                    planR: ratingPlan,
                    judgeID: userProfileID,
                  );
                  addPostToListOfGrants(e);
                })
          ],
        ));
  }
}
