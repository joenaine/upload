// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/constants/app_assets.dart';
import 'package:googleauth/constants/app_colors_const.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    this.controller,
    required this.onChanged,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String) onChanged;
  final void Function() onClear;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borders),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: TextField(
            controller: widget.controller,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                isTap = true;
              });
            },
            onSubmitted: (value) {
              setState(() {
                isTap = false;
              });
            },
            decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 20, minWidth: 20),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.svg.searchSmall, height: 20),
                    const SizedBox(width: 10)
                  ],
                ),
                suffixIcon: (isTap)
                    ? IconButton(
                        icon: SvgPicture.asset(AppAssets.svg.xcircle),
                        onPressed: () {
                          widget.controller?.clear();
                          widget.onClear();
                        })
                    : null,
                hintText: 'Поиск...',
                border: InputBorder.none)),
      ),
    );
  }
}
