import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/models/grants.dart';
import 'package:googleauth/widgets/app_global_loader_widget.dart';

import '../../constants/app_assets.dart';

class UserDocumentsList extends StatefulWidget {
  const UserDocumentsList({Key? key, this.userId}) : super(key: key);
  final String? userId;

  @override
  State<UserDocumentsList> createState() => _UserDocumentsListState();
}

class _UserDocumentsListState extends State<UserDocumentsList> {
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
                : Row(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // changeScreen(context, const UserDocumentsList());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(grant.docName!, style: AppStyles.s14w400),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                grant.doc!,
                                textAlign: TextAlign.start,
                                style: AppStyles.s14w400,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: grant.estimates?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = grant.estimates?[index];
                                  return Text(data.actualR);
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
      appBar: AppBar(),
      body: _trashPickersList(),
    );
  }
}
