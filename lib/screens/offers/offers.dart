import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/offers/components/body.dart';

import 'package:redcircleflutter/size_config.dart';
import '../../constants.dart';

class Offers extends StatelessWidget {
  static String routeName = "/calendar";
  Offers(this.controller);
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          "OFFERS",
          style: TextStyle(
              color: kPrimaryColor, fontSize: getProportionateScreenHeight(23)),
        ),
        toolbarHeight: getProportionateScreenHeight(90),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => controller.animateToPage(
            0,
            duration: Duration(milliseconds: 1),
            curve: Curves.linear,
          ),
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
