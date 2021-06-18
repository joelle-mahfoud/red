import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: "Raleway",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    fillColor: Colors.transparent,
    filled: true,
    hintStyle: TextStyle(color: kTextColor, fontStyle: FontStyle.italic),
    labelStyle: TextStyle(color: kTextColor),
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),

    button: TextStyle(color: Colors.transparent),
    caption: TextStyle(color: Colors.indigoAccent),
    subtitle1: TextStyle(color: Colors.red), // <-- that's the one
    headline1: TextStyle(color: Colors.deepOrangeAccent),
    headline2: TextStyle(color: Colors.black45),
    headline3: TextStyle(color: Colors.greenAccent),
    headline4: TextStyle(color: Colors.greenAccent),
    headline5: TextStyle(color: Colors.blue),
    headline6: TextStyle(color: Colors.yellow),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.black,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      // headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      headline6: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
