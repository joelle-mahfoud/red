import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';
import 'components/Body.dart';

class About extends StatelessWidget {
  static String routeName = "/about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KBackgroundColor,
        brightness: Brightness.dark,
        title: Text(
          "ABOUT RED CIRCLE",
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
