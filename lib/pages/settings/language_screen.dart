import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_assets.dart';
import '../../widgets/create_with_radio.dart';

enum LanguageType {
  kazakh,
  russian,
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  LanguageType? langType = LanguageType.russian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Выберите язык'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(AppAssets.svg.arrowleft))),
      body: CreateWithRadio(space: 4, title: 'Выберите язык', children: [
        ListTile(
          horizontalTitleGap: -5,
          contentPadding: EdgeInsets.zero,
          title: const Text('Казахский язык'),
          leading: Transform.scale(
            scale: 1.3,
            child: Radio(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: LanguageType.kazakh,
                groupValue: langType,
                onChanged: (LanguageType? value) {}),
          ),
        ),
        ListTile(
          horizontalTitleGap: -5,
          contentPadding: EdgeInsets.zero,
          title: const Text('Русский язык'),
          leading: Transform.scale(
            scale: 1.3,
            child: Radio(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: LanguageType.russian,
                groupValue: langType,
                onChanged: (LanguageType? value) {
                  setState(() {
                    langType = value;
                  });
                }),
          ),
        ),
      ]),
    );
  }
}
