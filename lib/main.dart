import 'package:flutter/material.dart';
import 'package:redcircleflutter/routes.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import 'package:redcircleflutter/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'functions/login.dart';

Future<bool> autoLogin() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String username = _pref.getString(kEmailPrefKey);
  String pass = _pref.getString(kPassPrefKey);
  if (username == null || username == "" || username == null || pass == "") {
    return false;
  }
  dynamic res = await login(username, pass);
  if (res[0]) {
    return true;
  } else {
    return false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  autoLogin().then((p) => runApp(MyApp(autoLogin: p)));
}

class MyApp extends StatelessWidget {
  final bool autoLogin;
  MyApp({Key key, this.autoLogin}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RED CIRLCE',
      theme: theme(),

      //home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: autoLogin ? HomeScreen.routeName : SignInScreen.routeName,
      routes: routes,
    );
  }

  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     // Replace the 3 second delay with your initialization code:
  //     future: Future.delayed(Duration(seconds: 3)),
  //     builder: (context, AsyncSnapshot snapshot) {
  //       // Show splash screen while waiting for app resources to load:
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           theme: theme(),
  //           home: SplashScreen(),
  //           // initialRoute: SplashScreen.routeName,
  //           // routes: routes,
  //         );
  //       } else {
  //         // Loading is done, return the app:
  //         return MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           title: 'Flutter Demo',
  //           theme: theme(),
  //           // home: SplashScreen(),
  //           // We use routeName so that we dont need to remember the name
  //           home: SignInScreen(),
  //           //initialRoute: SignInScreen.routeName,
  //           routes: routes,
  //         );
  //       }
  //     },
  //   );
  // }
}
