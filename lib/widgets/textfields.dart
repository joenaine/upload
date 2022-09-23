import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/services.dart';
import 'package:googleauth/constants/app_colors_const.dart';
import 'package:googleauth/constants/app_styles_const.dart';

import '../constants/app_assets.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    this.passwordController,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.formKey,
    this.onSaved,
  }) : super(key: key);

  final TextEditingController? passwordController;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Key? formKey;
  final FormFieldSetter<String>? onSaved;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borders),
          borderRadius: BorderRadius.circular(4)),
      child: TextFormField(
        onSaved: widget.onSaved,
        key: widget.formKey,
        onChanged: widget.onChanged,
        validator: widget.validator,
        controller: widget.passwordController,
        textAlign: TextAlign.start,
        obscureText: !isVisible,
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: SvgPicture.asset(
                    isVisible ? AppAssets.svg.eye : AppAssets.svg.eyeSlash)),
            alignLabelWithHint: false,
            labelText: widget.hintText,
            border: const UnderlineInputBorder(),
            labelStyle: AppStyles.s16w400.copyWith(color: AppColors.textLight)),
        style: AppStyles.s16w400,
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.suffixIcon,
      this.isEnabled = false,
      this.prefixIcon,
      this.keyboardType,
      this.maxlines = 1,
      this.onTap,
      this.initialValue,
      this.inputFormatters,
      this.onChanged,
      this.bottom = 16,
      this.onSaved,
      this.hintTextWithoutLabel,
      this.isLabelEnabled = true,
      this.maxLength,
      this.autofocus = false,
      this.verticalPadding = 9})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isEnabled;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxlines;
  final GestureTapCallback? onTap;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final double? bottom;
  final FormFieldSetter<String>? onSaved;
  final String? hintTextWithoutLabel;
  final bool? isLabelEnabled;
  final double? verticalPadding;
  final int? maxLength;
  final bool autofocus;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottom!),
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borders),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          TextFormField(
            autofocus: widget.autofocus,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            initialValue: widget.initialValue,
            onTap: widget.onTap,
            maxLines: widget.maxlines,
            keyboardType: widget.keyboardType,
            readOnly: widget.isEnabled,
            maxLength: widget.maxLength,
            controller: widget.controller,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget
                      .verticalPadding!), //Change this value to custom as you like
              isDense: true,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 20, minWidth: 20),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
              prefixIcon: widget.prefixIcon,
              disabledBorder: InputBorder.none,
              suffixIcon: widget.suffixIcon,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              alignLabelWithHint: false,
              labelText: (widget.isLabelEnabled!) ? widget.hintText : null,
              hintText: widget.hintTextWithoutLabel,
              border: const UnderlineInputBorder(),
              labelStyle:
                  AppStyles.s16w400.copyWith(color: AppColors.textLight),
            ),
            style: AppStyles.s16w400,
          ),
        ],
      ),
    );
  }
}
