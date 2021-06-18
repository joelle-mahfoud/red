import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/wallet/component/cashcreditform.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                getProportionateScreenWidth(SizeConfig.screenWidth * 0.03)),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.03),
              ),
              Text(
                "TOTAL CREDIT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "€16.200",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.04),
              ),
              Container(
                width: getProportionateScreenWidth(250),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CASH CREDIT",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "€15.500",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.01),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "REWARDS",
                          style: TextStyle(color: kPrimaryColor, fontSize: 18),
                        ),
                        Text(
                          "€700",
                          style: TextStyle(color: kPrimaryColor, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.04),
                    ),
                    Text(
                      "When you spend or receive credit. it will appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white30, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    getProportionateScreenHeight(SizeConfig.screenHeight * 0.1),
              ),
              Text(
                "TOP UP CASH CREDIT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.05),
              ),
              CashCreditRorm(),
            ],
          ),
        ),
      ),
    );
  }
}
