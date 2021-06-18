import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';

import 'components/Body.dart';

class MembershipApplicationAbout extends StatelessWidget {
  static String routeName = "/MembershipApplication_About";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "MEMBERSHIP \nAPPLICATION",
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
