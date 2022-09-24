import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelClass {
  final int? accountType;
  final Timestamp? createdAt;
  final String? email;
  final String? firstname;
  final String? id;
  final String? iin;
  final String? lastname;
  final String? middlename;
  final String? password;
  final String? phone;
  UserModelClass(
      {this.accountType,
      this.createdAt,
      this.email,
      this.firstname,
      this.id,
      this.iin,
      this.lastname,
      this.middlename,
      this.password,
      this.phone});

  factory UserModelClass.fromDocument(DocumentSnapshot doc) {
    return UserModelClass(
      accountType: doc['accountType'],
      createdAt: doc['createdAt'],
      email: doc['email'],
      firstname: doc['firstname'],
      id: doc['id'],
      iin: doc['iin'],
      lastname: doc['lastname'],
      middlename: doc['middlename'],
      password: doc['password'],
      phone: doc['phone'],
    );
  }
}
