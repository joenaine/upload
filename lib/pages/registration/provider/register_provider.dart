import 'package:flutter/material.dart';
import 'package:googleauth/pages/registration/fill_the_forms_screen.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController firstname = TextEditingController();
  TextEditingController middlename = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController iin = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  AccountType? accountType = AccountType.first;
}
