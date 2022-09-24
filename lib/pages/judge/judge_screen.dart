import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/firebase_consts.dart';
import 'package:googleauth/models/grants.dart';
import 'package:googleauth/widgets/app_global_loader_widget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_styles_const.dart';
import '../../constants/screen_navigation_const.dart';
import '../login_screen.dart';

class JudgeScreen extends StatefulWidget {
  const JudgeScreen({Key? key}) : super(key: key);

  @override
  State<JudgeScreen> createState() => _JudgeScreenState();
}

class _JudgeScreenState extends State<JudgeScreen> {
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
                            "Сборщики сырья еще не зарегистрированы",
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
      child: Container(
        child: GestureDetector(
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
                  : Row(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // changeScreen(
                              //     context,
                              //     UserDocumentsList(
                              //       userId: userModelClass.id,
                              //     ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(grantsModel.docName!,
                                    style: AppStyles.s14w400),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome Judge'),
          grantsCard(),
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
}
