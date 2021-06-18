import 'package:flutter/material.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/screens/wallet/component/body.dart';
import 'package:redcircleflutter/size_config.dart';
import '../../constants.dart';

class Wallet extends StatelessWidget {
  static String routeName = "/Requests";
  Wallet(this.controller);
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: kPrimaryColor,
              height: .5,
              width: getProportionateScreenWidth(SizeConfig.screenWidth * 0.9),
            ),
            preferredSize: Size.fromHeight(4.0)),
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          "WALLET & REWARDS",
          style: TextStyle(
              color: kPrimaryColor, fontSize: getProportionateScreenHeight(23)),
        ),
        toolbarHeight: getProportionateScreenHeight(100),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
            iconSize: getProportionateScreenHeight(35),
            onPressed: () => {
                  KeyboardUtil.hideKeyboard(context),
                  controller.animateToPage(
                    0,
                    duration: Duration(milliseconds: 1),
                    curve: Curves.linear,
                  ),
                }),
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
