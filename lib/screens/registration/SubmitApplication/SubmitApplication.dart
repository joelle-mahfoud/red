import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';

import 'components/Body.dart';

class SubmitApplication extends StatelessWidget {
  static String routeName = "/MembershipApplication_Submit";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Membership;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "SUBMIT \nAPPLICATION",
          textAlign: TextAlign.center,
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
          child: Body(membership: args),
        ),
      ),
    );
  }
}
