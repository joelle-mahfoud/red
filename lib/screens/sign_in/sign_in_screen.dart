import 'package:flutter/material.dart';
import 'package:redcircleflutter/components/Exit.dart';
import 'package:redcircleflutter/size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.cover),
          ),
          child: new WillPopScope(
              onWillPop: () => onWillPop(context), child: Body()),
        ),
      ),
    );
  }
}
