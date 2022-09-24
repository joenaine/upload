import 'package:cloud_firestore/cloud_firestore.dart';

class GrantsModel {
  final String? doc;
  final String? docID;
  final String? userID;
  final String? docName;
  final Timestamp? postedDate;
  final String? projectName;
  final String? desc;
  final List<dynamic>? estimates;

  GrantsModel(
      {this.doc,
      this.docID,
      this.docName,
      this.postedDate,
      this.desc,
      this.projectName,
      this.userID,
      this.estimates});

  factory GrantsModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return GrantsModel(
      doc: documentSnapshot['doc'],
      docID: documentSnapshot['docID'],
      docName: documentSnapshot['docName'],
      postedDate: documentSnapshot['postedDate'],
      projectName: documentSnapshot['projectName'],
      desc: documentSnapshot['desc'],
      userID: documentSnapshot['userID'],
      estimates: documentSnapshot['estimates'],
    );
  }
}
