import 'package:flutter/material.dart';
import 'package:googleauth/constants/firebase_consts.dart';

import '../../constants/screen_navigation_const.dart';
import '../login_screen.dart';

class JudgeScreen extends StatelessWidget {
  const JudgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome Judge'),
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
