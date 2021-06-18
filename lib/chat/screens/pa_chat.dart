import 'package:flutter/material.dart';
import 'package:redcircleflutter/chat/chatWidget.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/size_config.dart';

class PAChat extends StatefulWidget {
  final String productid;
  final String productName;
  const PAChat({this.productid, this.productName});

  @override
  _PAChatState createState() => _PAChatState();
}

class _PAChatState extends State<PAChat> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       brightness: Brightness.dark,
  //       backgroundColor: KBackgroundColor,
  //       title: Text(
  //         "",
  //         maxLines: 2,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: kPrimaryColor,
  //           fontSize: getProportionateScreenHeight(23),
  //         ),
  //       ),
  //       toolbarHeight: getProportionateScreenHeight(120),
  //       centerTitle: true,
  //       leading: IconButton(
  //         icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
  //         iconSize: 35,
  //         onPressed: () => Navigator.of(context).pop(),
  //       ),
  //     ),
  //     body: WillPopScope(
  //         onWillPop: () async {
  //           return false;
  //         },
  //         child: ChatWidget.widgetWelcomeScreen(context)),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // ChatData1.initCustom(
    //     "RedCircle Chat ", context, widget.productid, widget.productName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          "",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenHeight(23),
          ),
        ),
        toolbarHeight: getProportionateScreenHeight(120),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: ChatWidget.widgetWelcomeScreen(context)),
    );
  }
}
