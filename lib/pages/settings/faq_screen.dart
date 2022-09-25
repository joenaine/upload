import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors_const.dart';
import '../../../constants/app_styles_const.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> titleItems = [
      [
        'Что означает ',
        'Ответ: это объединение двух слов: easy (izi) - в переводе с английского "легко", а также dos - в переводе с казахского "друг" и в переводе с латинского и испанского - два, пара, напарник.'
      ],
      [
        'Сколько стоит участие в одной игре/матче?',
        'Ответ: стоимость участия зависит от установленной организатором игры суммы оплаты, это от 0 тенге и выше.'
      ],
      [
        'Какие существуют способы оплаты?',
        'Ответ: оплата может быть произведена наличными организатору или онлайн-оплатой через приложение.'
      ],
      [
        'Как вернуть деньги, если игра/матч не состоялся?',
        'Ответ: Если игра не состоялась, возврат средств осуществляется в полном объеме тем же способом, каким была оплата за участие - наличными или онлайн.'
      ],
      [
        'Зачем нужен рейтинг (отзыв) прльзователя? ',
        'Ответ: Рейтинг и отзывы предназначены для облегчения поиска и выбора подходящего для Вас партнера. '
      ],
      [
        'Как предоставляется рейтинг (отзыв) пользователю приложения?',
        'Ответ: После каждой игры/матча приложение направляет уведомление для оценки партнера(-ов). Возможность оценить открыта в течение нескольких часов после совместной игры.'
      ],
      [
        'Зачем нужны закрытые сообщества или игры?',
        'Ответ: Для ограничения количества потенциальных участников игры/матча, так сказать, для создания игр "только для своих".'
      ],
      [
        'Для каких видов спорта предназначино приложение izidos?',
        'Ответ: Для всех. Однако, в первоначальной стадии более активно развивается футбольное направление. На следующих этапах, планируется постепенное расширение на другие виды спорта (волейбол, хоккей, баскетбол, теннис и т.д.)'
      ],
      [
        'Как организоват игру/матч в приложении?',
        'Ответ: Чтобы получить возможность организовать игру необходимо пройти верификацию в приложение.'
      ],
      [
        'Что означает синяя галочка в профиле пользователя?',
        'Ответ: Синяя галочка в профиле пользователя означает, что этот человек прошел верификацию в приложении и ему доверена возможность организовывать игры/матчи.'
      ],
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вопросы и ответы'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.svg.arrowleft)),
      ),
      body: ListView.separated(
        itemCount: titleItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTileCustom(
              title: titleItems[index][0], subtitle: titleItems[index][1]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4);
        },
      ),
    );
  }
}

class ExpansionTileCustom extends StatelessWidget {
  const ExpansionTileCustom({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedIconColor: AppColors.textLight,
        iconColor: AppColors.textLight,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        collapsedBackgroundColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(title, style: AppStyles.s16w500),
        children: [Text(subtitle, style: AppStyles.s16w400)]);
  }
}
