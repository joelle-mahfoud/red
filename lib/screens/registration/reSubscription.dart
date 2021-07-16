import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';

class ReSubscription extends StatefulWidget {
  const ReSubscription({Key key}) : super(key: key);

  @override
  _ReSubscriptionState createState() => _ReSubscriptionState();
}

class _ReSubscriptionState extends State<ReSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "Renew Subscription",
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
          child: Text(
              "Please your subscription fisnied ,should be renew it or select another package."),
        ),
      ),
    );
  }
}
