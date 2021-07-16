import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/ArgumentsData.dart';
import '../confirmBillingCycle/components/Body.dart';

class ConfirmBillingCycle extends StatelessWidget {
  static String routeName = "/ConfirmBillingCycle";
  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);
    final ArgumentsData args =
        ModalRoute.of(context).settings.arguments as ArgumentsData;

    // final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "CONFIRM YOUR \nBILLING CYCLE",
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
          child: Body(argumentsData: args),
        ),
      ),
    );
  }
}
