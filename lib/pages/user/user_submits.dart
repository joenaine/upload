import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/pages/app_nav_bar.dart';

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
