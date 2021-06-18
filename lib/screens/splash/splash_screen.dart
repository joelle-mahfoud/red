import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/splash/components/body.dart';
import 'package:redcircleflutter/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.cover),
          ),
          child: Body(),
        ),
      ),
    );
  }
}
