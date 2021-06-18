import 'package:flutter/material.dart';
import 'package:redcircleflutter/models/Product.dart';
import 'package:redcircleflutter/screens/registration/assistance/assistance.dart';
// import 'package:redcircleflutter/components/new_to_redcircle.dart';
// import 'package:redcircleflutter/screens/about/about.dart';
import 'package:redcircleflutter/screens/registration/confirmBillingCycle/components/Radio.dart';
import 'package:redcircleflutter/screens/registration/membershipApplication_About/membership_application_about.dart';
import '../../../../size_config.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                getProportionateScreenWidth(SizeConfig.screenWidth * 0.03)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kPrimaryColor,
              height:
                  getProportionateScreenHeight(SizeConfig.screenHeight * 0.03),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: RadioConfirmBillingCycle(),
              ),
            ),
            // SizedBox(height: SizeConfig.screenHeight * 0.04),
            Expanded(
              flex: 2,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your free trial begins on december1,2020 \nand will end on march 1,2021",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    "Your can cancel anytime before march 1,2021 \nto avoid being cahrged and we'll send an email reminder 3 days befor the trial ends.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Assistance.routeName),
                    child: Text(
                      "Require assistance?",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            InkWell(
              onTap: () => Navigator.pushNamed(
                  context, MembershipApplicationAbout.routeName,
                  arguments: demoProducts[0]),
              child: Container(
                // height: getProportionateScreenHeight(
                //     SizeConfig.screenHeight * 0.07),
                width:
                    getProportionateScreenWidth(SizeConfig.screenWidth * 0.85),
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(
                        SizeConfig.screenHeight * 0.02)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: KBorderColor,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "CONTINUE   ",
                        style: TextStyle(
                            color: Color.fromRGBO(22, 22, 23, 0.8),
                            fontFamily: "Raleway",
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.w600),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: Color.fromRGBO(22, 22, 23, 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04)
          ],
        ),
      ),
    );
  }
}
