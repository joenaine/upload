import 'package:flutter/material.dart';
import 'package:googleauth/pages/admin/admin_screen.dart';
import 'package:googleauth/pages/judge/judge_screen.dart';
import 'package:googleauth/pages/user/user_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.accountType}) : super(key: key);
  final int? accountType;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: widget.accountType != 3
              ? widget.accountType == 1
                  ? const UserScreen()
                  : const JudgeScreen()
              : const AdminScreen()),
    );
  }
}
