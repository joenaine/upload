import 'package:flutter/material.dart';
import 'package:googleauth/main.dart';

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
        child: accountType != 3
            ? accountType == 1
                ? const Center(child: Text('Welcome User'))
                : const Center(child: Text('Welcome Judge'))
            : const Center(child: Text('Welcome Admin')),
      ),
    );
  }
}
