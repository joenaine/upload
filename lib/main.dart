import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:googleauth/constants/firebase_consts.dart';
import 'package:googleauth/pages/registration/provider/register_provider.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors_const.dart';
import 'constants/app_styles_const.dart';
import 'pages/home.dart';
import 'pages/login_screen.dart';

final user = authInstance.currentUser;
int? accountType;
Timestamp? createdAt;
String? email;
String? firstname;
String? id;
String? iin;
String? lastname;
String? middlename;
String? password;
String? phone;

Future<void> geAccountType() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid)
      .get()
      .then((value) {
    accountType = value.data()?["accountType"];
    createdAt = value.data()?["createdAt"];
    email = value.data()?["email"];
    firstname = value.data()?["firstname"];
    id = value.data()?["id"];
    iin = value.data()?["iin"];
    lastname = value.data()?["lastname"];
    middlename = value.data()?["middlename"];
    password = value.data()?["password"];
    phone = value.data()?["phone"];
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (user != null) {
    await geAccountType();
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _mainPage() {
    if (user == null) {
      return const Login();
    } else {
      return Home(accountType: accountType);
      //return PickTrashLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'grant',
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.bg,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0.5,
                backgroundColor: AppColors.white,
                toolbarTextStyle: AppStyles.s14w400,
                titleTextStyle: AppStyles.s16w500,
                iconTheme: IconThemeData(color: AppColors.dark)),
            primarySwatch: Colors.blue,
            primaryColor: AppColors.primary,
            fontFamily: 'Inter',
            backgroundColor: AppColors.bg,
            iconTheme: const IconThemeData(color: AppColors.dark)),
        home: _mainPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
