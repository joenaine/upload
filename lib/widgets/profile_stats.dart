import 'package:flutter/material.dart';

import 'header18.dart';

class Stats extends StatelessWidget {
  const Stats({
    Key? key,
    required this.title,
    this.number = 0,
  }) : super(key: key);
  final String title;
  final int? number;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 8),
        HeaderText(text: '$number раз')
      ],
    );
  }
}
