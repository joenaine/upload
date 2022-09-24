import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/firebase_consts.dart';
import 'package:googleauth/widgets/container16.dart';
import 'package:googleauth/widgets/discolored_button.dart';
import 'package:googleauth/widgets/modal_bottom.dart';
import 'package:googleauth/widgets/toast.dart';

import '../../Generators/uui_generator.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_styles_const.dart';
import '../../constants/screen_navigation_const.dart';
import '../login_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late FToast fToast;
  String docId = UUIDGenerator().uuidV4();
  final user = authInstance.currentUser;
  final String userProfileID =
      FirebaseAuth.instance.currentUser!.uid.toString();
  final firestoreInstance = FirebaseFirestore.instance;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future uploadFile() async {
    final path = 'files/${user?.uid}/$docId';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    addPostToFireStore(urlDownload);
    print('Download Link: $urlDownload');
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<void> addPostToFireStore(String doc) async {
    firestoreInstance
        .collection('users')
        .doc(userProfileID)
        .collection('Grants')
        .doc(docId)
        .set({
          'docID': docId,
          'doc': doc,
          'postedDate': Timestamp.now(),
          'docName': pickedFile!.name
        })
        .then(
          (value) => fToast.showToast(
            child: const ToastContainer(text: "Успешно загружено"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          ),
        )
        .catchError(
          (error) => fToast.showToast(
            child: const ToastContainer(
                text: "Произошла ошибка", color: AppColors.error),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователь'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome User'),
          if (pickedFile != null) Text(pickedFile!.name),
          Container16(
              child:
                  DiscoloredButton(text: 'Загрузить', onPressed: uploadFile)),
          GestureDetector(
            onTap: (() {
              FlexibleBottomSheet.flexBottomSheet(context, 0, 0, [
                GestureDetector(
                    onTap: () {
                      selectFile();
                      Navigator.pop(context);
                    },
                    child: const Text('Выбрать файл', style: AppStyles.s16w400))
              ]);
            }),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.white,
              child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(4),
                  dashPattern: const [4, 4],
                  color: AppColors.primary,
                  strokeWidth: 2,
                  child: Container(
                    color: AppColors.bg,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        SvgPicture.asset(AppAssets.svg.download),
                        const SizedBox(height: 10),
                        const Text('Добавьте свой документ',
                            style: AppStyles.s16w400)
                      ],
                    ),
                  )),
            ),
          ),
          buildProgress(),
          ElevatedButton(
              onPressed: () async {
                await authInstance.signOut();
                // ignore: use_build_context_synchronously
                changeScreenByRemove(context, const Login(), '/login');
              },
              child: const Text('Выйти'))
        ],
      )),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.success,
                    color: AppColors.success,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: AppStyles.s12w400,
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        },
      );
}
