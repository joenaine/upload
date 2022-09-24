import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/constants/screen_navigation_const.dart';
import 'package:googleauth/pages/registration/fill_the_forms_screen.dart';
import 'package:googleauth/pages/registration/provider/register_provider.dart';
import 'package:googleauth/services/global_methods.dart';
import 'package:googleauth/widgets/general_button.dart';
import 'package:googleauth/widgets/textfields.dart';
import 'package:provider/provider.dart';

import '../../constants/firebase_consts.dart';
import '../login_screen.dart';

class PasswordRegistration extends StatefulWidget {
  const PasswordRegistration({Key? key}) : super(key: key);

  @override
  State<PasswordRegistration> createState() => _PasswordRegistrationState();
}

class _PasswordRegistrationState extends State<PasswordRegistration> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  int? accountType;
  bool onCorrespond = false;
  bool onLength = false;
  bool _isLoading = false;

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

  void _submitFormOnRegister() async {
    final regP = Provider.of<RegisterProvider>(context, listen: false);
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await authInstance.createUserWithEmailAndPassword(
              email: regP.email.text.toLowerCase().trim(),
              password: password.text.trim());
      final User? user = authInstance.currentUser;
      final uid = user!.uid;
      // user.updateDisplayName(regP.firstname.text);
      // user.reload();
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'accountType': regP.accountType != AccountType.third
            ? regP.accountType == AccountType.first
                ? 1
                : 2
            : 3,
        'firstname': regP.firstname.text,
        'middlename': regP.middlename.text,
        'lastname': regP.lastname.text,
        'iin': regP.iin.text,
        'email': regP.email.text.toLowerCase(),
        'phone': regP.phone.text.toLowerCase(),
        'password': password.text,
        'createdAt': Timestamp.now(),
      });
      await geAccountType(userCredential.user!.uid.toString());
      // ignore: use_build_context_synchronously
      changeScreenByRemove(context, Login(accountType: accountType), '/login');
      print('Succefully registered');
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .98),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(AppAssets.images.shield)),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Придумайте пароль',
                        style: AppStyles.s24w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    PasswordTextField(
                      passwordController: password,
                      // passwordController: controllerProvider.passController,
                      hintText: 'Пароль',
                    ),
                    const SizedBox(height: 16),
                    PasswordTextField(
                      passwordController: passwordConfirm,
                      // passwordController:
                      //     controllerProvider.passConfirmController,
                      hintText: 'Введите пароль еще раз',
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Пароль должен сожержать не менее 8 символов',
                      style: AppStyles.s12w400.copyWith(
                          color: (!onLength)
                              ? AppColors.textLight
                              : AppColors.error),
                    ),
                    if (onCorrespond)
                      Text(
                        'Пароли не совпадают',
                        style:
                            AppStyles.s12w400.copyWith(color: AppColors.error),
                      ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: GeneralButton(
                          isLoading: _isLoading,
                          text: 'Продолжить',
                          onPressed: () async {
                            _submitFormOnRegister();
                            // if (controllerProvider.passController.text.length >
                            //         7 &&
                            //     controllerProvider.passController.text ==
                            //         controllerProvider
                            //             .passConfirmController.text) {
                            //   Navigator.pushReplacementNamed(
                            //       context, '/phoneNumber');
                            // }
                            // if (controllerProvider.passController.text !=
                            //     controllerProvider.passConfirmController.text) {
                            //   setState(() {
                            //     onCorrespond = true;
                            //   });
                            // }
                            // if (controllerProvider.passController.text ==
                            //         controllerProvider
                            //             .passConfirmController.text &&
                            //     controllerProvider.passController.text.length <
                            //         8) {
                            //   setState(() {
                            //     onCorrespond = false;
                            //     onLength = true;
                            //   });
                            // }
                            // if (controllerProvider.passController.text !=
                            //         controllerProvider
                            //             .passConfirmController.text &&
                            //     controllerProvider.passController.text.length >
                            //         7) {
                            //   setState(() {
                            //     onCorrespond = true;
                            //     onLength = false;
                            //   });
                            // }
                            // if (controllerProvider.passController.text.length <
                            //     8) {
                            //   setState(() {
                            //     onLength = true;
                            //   });
                            // } else {
                            //   setState(() {
                            //     onLength = false;
                            //   });
                            // }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
