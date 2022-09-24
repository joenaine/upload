import 'package:cloud_firestore/cloud_firestore.dart';

class GrantsModel {
  final String? doc;
  final String? docID;
  final String? docName;
  final Timestamp? postedDate;

  GrantsModel({this.doc, this.docID, this.docName, this.postedDate});

  factory GrantsModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return GrantsModel(
      doc: documentSnapshot['doc'],
      docID: documentSnapshot['docID'],
      docName: documentSnapshot['docName'],
      postedDate: documentSnapshot['postedDate'],
    );
  }
}
