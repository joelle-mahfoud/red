import 'package:flutter/material.dart';
// import 'package:redcircleflutter/components/freetrial_button.dart';
import 'package:redcircleflutter/components/new_to_redcircle.dart';
// import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/about/about.dart';
import 'package:redcircleflutter/screens/membership_plan/MemberShipPlan.dart';
// import 'package:redcircleflutter/components/no_account_text.dart';
// import 'package:redcircleflutter/components/socal_card.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
// import 'package:redcircleflutter/components/redcircletext.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                Container(
                    height: getProportionateScreenHeight(
                        SizeConfig.screenHeight * 0.08),
                    width: getProportionateScreenWidth(
                        SizeConfig.screenWidth * 0.75),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    )),
                // RedCircleText(sizetext: 40, sizeC: 70),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "WELCOME TO OUR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(28),
                  ),
                ),
                Text(
                  "WORLD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(28),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                HyperLink(
                  title: "NEW TO RED CIRCLE?",
                  titleColor: Colors.white,
                  fontsize: getProportionateScreenWidth(22),
                  press: () => Navigator.pushNamed(context, About.routeName),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),

                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, MembershipPlan.routeName),
                  child: Container(
                    width: getProportionateScreenWidth(300),
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.03)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(0)),
                      border: Border.all(color: KBorderColor, width: 0.4),
                    ),
                    child: Text(
                      "TRY FREE MEMBERSHIP",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                      ),
                    ),
                  ),
                ),

                // FreeTrialButton(
                //   text: "TRY FREE MEMBERSHIP",
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
