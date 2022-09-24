import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/firebase_consts.dart';
import 'package:googleauth/models/grants.dart';
import 'package:googleauth/models/user_model.dart';
import 'package:googleauth/pages/judge/judge_project_details.dart';
import 'package:googleauth/widgets/app_global_loader_widget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_styles_const.dart';
import '../../constants/screen_navigation_const.dart';
import '../login_screen.dart';

class JudgeScreen extends StatefulWidget {
  const JudgeScreen({Key? key, this.userModelClass}) : super(key: key);
  final UserModelClass? userModelClass;

  @override
  State<JudgeScreen> createState() => _JudgeScreenState();
}

class _JudgeScreenState extends State<JudgeScreen> {
  final user = authInstance.currentUser;
  int? accountType;
  Timestamp? createdAt;
  String? email;
  String? firstname;
  String? id;
  String? iin;
  String? lastname;
  String? middlename;
  String? password;
  String? phone;

  Future<void> _geAccountType() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      accountType = value.data()?["accountType"];
      createdAt = value.data()?["createdAt"];
      email = value.data()?["email"];
      firstname = value.data()?["firstname"];
      id = value.data()?["id"];
      iin = value.data()?["iin"];
      lastname = value.data()?["lastname"];
      middlename = value.data()?["middlename"];
      password = value.data()?["password"];
      phone = value.data()?["phone"];
    });
  }

  @override
  void initState() {
    super.initState();
    _geAccountType();
  }

  Widget grantsCard() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("grants").snapshots(),
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
              changeScreen(
                  context,
                  JudgeProjectDetails(
                      grantsModel: grantsModel,
                      firstname: firstname,
                      middlename: middlename,
                      lastname: lastname));
            },
            child: snapshot.data?.docs.length == null
                ? Container()
                : Row(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(grantsModel.userID!,
                                  style: AppStyles.s10w400),
                              Text(grantsModel.projectName!,
                                  style: AppStyles.s14w400),
                              Text(grantsModel.desc!, style: AppStyles.s14w400),
                              const SizedBox(
                                height: 5.0,
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
        title: const Text('Жюри'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            grantsCard(),
            ElevatedButton(
                onPressed: () async {
                  await authInstance.signOut();
                  // ignore: use_build_context_synchronously
                  changeScreenByRemove(context, const Login(), '/login');
                },
                child: const Text('Выйти')),
          ],
        ),
      ),
    );
  }
}
