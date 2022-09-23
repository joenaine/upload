import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_regex_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';
import 'package:googleauth/constants/screen_navigation_const.dart';
import 'package:googleauth/pages/registration/provider/register_provider.dart';
import 'package:googleauth/pages/registration/register_password_screen.dart';
import 'package:googleauth/widgets/app_hide_keyboard_widget.dart';
import 'package:googleauth/widgets/general_button.dart';
import 'package:googleauth/widgets/textfields.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

enum AccountType { first, second, third }

class RegisterFillFormsScreen extends StatefulWidget {
  const RegisterFillFormsScreen({Key? key}) : super(key: key);

  @override
  State<RegisterFillFormsScreen> createState() =>
      _RegisterFillFormsScreenState();
}

class _RegisterFillFormsScreenState extends State<RegisterFillFormsScreen> {
  DateTime? selectedDate;
  late MaskTextInputFormatter _phoneMaskController;
  bool _onChanged = false;
  late FToast fToast;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneMaskController = MaskTextInputFormatter(
        mask: AppRegexPattern.phoneKZ,
        filter: {"#": AppRegexPattern.digitRegex});
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final regP = Provider.of<RegisterProvider>(context);
    var size = MediaQuery.of(context).size;
    return AppHideKeyBoardWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
            child: Column(
              children: [
                Center(child: Image.asset(AppAssets.images.form)),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: const [
                      Text('Заполните данные о себе', style: AppStyles.s24w600),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Имя',
                  controller: regP.firstname,
                ),
                CustomTextField(
                  hintText: 'Фамилия',
                  controller: regP.middlename,
                ),
                CustomTextField(
                  hintText: 'Отчество',
                  controller: regP.lastname,
                ),
                CustomTextField(
                  hintText: 'ИИН',
                  controller: regP.iin,
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'E-mail',
                  controller: regP.email,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borders),
                      borderRadius: BorderRadius.circular(4)),
                  child: TextFormField(
                      onChanged: (str) {
                        if (_phoneMaskController.getUnmaskedText().length ==
                            11) {
                          FocusScope.of(context).unfocus();
                        }
                        if (str.length == 18) {
                          setState(() {
                            _onChanged = true;
                          });
                        } else {
                          setState(() {
                            _onChanged = false;
                          });
                        }
                      },
                      inputFormatters: [_phoneMaskController],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          hintText: '+7',
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          alignLabelWithHint: false,
                          border: InputBorder.none)),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 145,
                      child: ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Пользователь',
                          style: AppStyles.s14w400,
                        ),
                        leading: Transform.scale(
                          scale: 1.0,
                          child: Radio(
                              value: AccountType.first,
                              groupValue: regP.accountType,
                              onChanged: (AccountType? value) {
                                setState(() {
                                  regP.accountType = value;
                                });
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Жюри',
                          style: AppStyles.s14w400,
                        ),
                        leading: Transform.scale(
                          scale: 1.0,
                          child: Radio(
                              value: AccountType.second,
                              groupValue: regP.accountType,
                              onChanged: (AccountType? value) {
                                setState(() {
                                  regP.accountType = value;
                                });
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Админ',
                          style: AppStyles.s14w400,
                        ),
                        leading: Transform.scale(
                          scale: 1.0,
                          child: Radio(
                              value: AccountType.third,
                              groupValue: regP.accountType,
                              onChanged: (AccountType? value) {
                                setState(() {
                                  regP.accountType = value;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .025),
                GeneralButton(
                    text: 'Продолжить',
                    color: AppColors.primary,
                    onPressed: () {
                      regP.phone.text = _phoneMaskController.getMaskedText();
                      changeScreen(context, const PasswordRegistration());
                    }),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:
                          'Нажимая на кнопку «Продолжить», вы соглашаетесь c ',
                      style: AppStyles.s12w400.copyWith(height: 1.25),
                      children: [
                        TextSpan(
                            text: 'Пользовательским соглашением',
                            style: const TextStyle(color: AppColors.primary),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        const TextSpan(text: ' и '),
                        TextSpan(
                            text: 'Политикой конфиденциальности',
                            style: const TextStyle(color: AppColors.primary),
                            recognizer: TapGestureRecognizer()..onTap = () {})
                      ]),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
