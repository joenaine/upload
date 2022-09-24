import 'package:cloud_firestore/cloud_firestore.dart';

class EstimateModel {
  final String? judgeID;
  final double? ideaR;
  final double? planR;
  final double? actualR;

  EstimateModel({this.judgeID, this.ideaR, this.planR, this.actualR});

  factory EstimateModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return EstimateModel(
      judgeID: documentSnapshot['judgeID'],
      ideaR: documentSnapshot['ideaR'],
      planR: documentSnapshot['planR'],
      actualR: documentSnapshot['actualR'],
    );
  }
}
