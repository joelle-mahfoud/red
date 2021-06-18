import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/registration/assistance/components/assitanceForm.dart';
import '../../../../size_config.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Container(
                child: Text(
                  "If you require assitance, or you would \nlike to complete your application offline,\nPlease email",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Container(
                child: Text(
                  "membership@thesunsecretcollection.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    color: kPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Container(
                child: Text(
                  "or fill in the information below so our \nteam will be happy to help.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              AssitanceForm(),
              // SizedBox(height: SizeConfig.screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
