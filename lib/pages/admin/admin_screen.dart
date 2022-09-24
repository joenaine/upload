import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/models/grants.dart';
import 'package:googleauth/widgets/app_global_loader_widget.dart';

import '../../constants/firebase_consts.dart';
import '../../constants/screen_navigation_const.dart';
import '../login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  _trashPickersList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: StreamBuilder<QuerySnapshot>(
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
                          SvgPicture.asset(AppAssets.svg.unselectedAvatar),
                        ],
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        UserModelClass userModelClass =
                            UserModelClass.fromDocument(
                                snapshot.data.docs[index]);
                        return trashPickersDetailsCard(
                            snapshot, userModelClass);
                      },
                    );
        },
      ),
    );
  }

  getAllTrashPickUps() {
    FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(result.id)
            .collection("Grants")
            .get()
            .then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            GrantsModel grantsModel = GrantsModel.fromDocument(result);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome Admin'),
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
