import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/registration/assistance/components/Body.dart';

class Assistance extends StatelessWidget {
  static String routeName = "/Assistance";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "ASSISTANCE",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: KBackgroundColor,
          ),
          child: Body(),
        ),
      ),
    );
  }
}
