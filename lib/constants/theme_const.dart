import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemeData {
  static const Color primary = Color(0xFF3366FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF1D1D1D);
  static const Color disabled = Color(0xFFD2D2D2);
  static const Color borders = Color(0xFFD8D8D8);
  static const Color error = Color(0xFFFF4D35);
  static const Color yellow = Color(0xFFFFE923);
  static const Color success = Color(0xFF36C43E);
  static const Color bg = Color(0xFFF4F6FB);
  static const Color disabledButton = Color(0xFFD6E4FF);
  static const Color hoverButton = Color(0xFF1939B7);
  static const Color pressedButton = Color(0xFF102693);
  static const Color textLight = Color(0xFF7E7E7E);
  static const Color textDark = Color(0xFF202020);
  static const Color textDisabled = Color(0xFFB1B1B1);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    colorScheme: const ColorScheme.light(),
    primaryColor: primary,
    backgroundColor: bg,
    fontFamily: 'Inter',
    buttonTheme: const ButtonThemeData(
        disabledColor: disabledButton,
        hoverColor: hoverButton,
        splashColor: pressedButton),
    appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0.0),
    iconTheme: IconThemeData(color: Colors.grey.shade900),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
      headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
      headline4: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
      subtitle1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
      subtitle2: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: const Color.fromRGBO(34, 111, 39, 1),
    backgroundColor: Colors.grey.shade900,
    fontFamily: 'Open Sans',
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(color: Colors.grey.shade900, elevation: 0.0),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
      headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
      headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
      headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
      headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(secondary: const Color.fromRGBO(50, 163, 57, 1)),
  );
}
