import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/constants/firebase_consts.dart';
import 'package:googleauth/constants/screen_navigation_const.dart';
import 'package:googleauth/pages/home.dart';
import 'package:googleauth/widgets/app_hide_keyboard_widget.dart';
import 'package:googleauth/widgets/discolored_button.dart';
import 'package:googleauth/widgets/general_button.dart';
import 'package:googleauth/widgets/textfields.dart';

import '../services/global_methods.dart';
import 'registration/fill_the_forms_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.accountType}) : super(key: key);
  final int? accountType;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int? accountType;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  late FToast fToast;
  geAccountType(String userID) async {
    print("----------------------- CHECK ACCOUNT TYPE -----------------------");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      accountType = value.data()?["accountType"];
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.accountType != null) {
      accountType = widget.accountType;
    }

    fToast = FToast();
    fToast.init(context);
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await authInstance.signInWithEmailAndPassword(
              email: _emailController.text.toLowerCase().trim(),
              password: _passController.text.trim());
      await geAccountType(userCredential.user!.uid.toString());
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const Home(),
      //   ),
      // );
      print('Succefully logged in');
    } on FirebaseException catch (error) {
      GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget loginDisplay() {
    final size = MediaQuery.of(context).size;
    return AppHideKeyBoardWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        appBar: AppBar(elevation: 0),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: size.height * .09),
                const Text('????????', style: AppStyles.s24w600),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: 'Email',
                  controller: _emailController,
                ),
                PasswordTextField(
                    passwordController: _passController, hintText: '????????????'),
                const SizedBox(height: 16),
                GeneralButton(
                    isLoading: _isLoading,
                    text: '??????????',
                    onPressed: () {
                      _submitFormOnLogin();
                    }),
                const SizedBox(height: 16),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    onPressed: () {},
                    child: Text(
                      '???????????? ?????????????',
                      style:
                          AppStyles.s16w500.copyWith(color: AppColors.primary),
                    )),
                const Spacer(),
                DiscoloredButton(
                    text: '????????????????????????????????????',
                    onPressed: () {
                      changeScreenByRemove(context,
                          const RegisterFillFormsScreen(), '/register');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authInstance.currentUser;
    return user != null
        ? Home(
            accountType: accountType,
          )
        : loginDisplay();
  }
}
