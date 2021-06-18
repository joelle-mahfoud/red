import 'package:flutter/material.dart';
// import 'package:redcircleflutter/screens/registration/confirmBillingCycle/confirm_billing_cycle.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'MembershipTabs_firebase.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // _val = _prefs.then((SharedPreferences prefs) {
    //   return (prefs.getString('key') ?? 0);
    // });

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
            // MembershipTabs(),
            Expanded(
              // flex: 3,
              child: MembershipTabs(),
            ),
            // InkWell(
            //   onTap: () => {
            //     Navigator.pushNamed(context, ConfirmBillingCycle.routeName),
            //   },
            //   child: Container(
            //     width:
            //         getProportionateScreenWidth(SizeConfig.screenWidth * 0.85),
            //     padding: EdgeInsets.symmetric(
            //         vertical: getProportionateScreenHeight(
            //             SizeConfig.screenHeight * 0.02)),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       color: Colors.black,
            //       border: Border.all(
            //           color: Color.fromRGBO(171, 150, 94, 1), width: 0.8),
            //     ),
            //     child: RichText(
            //       text: TextSpan(
            //         children: [
            //           TextSpan(
            //             text: "START YOUR FREE 3-MONTH TRIAL   ",
            //             style: TextStyle(
            //                 color: kPrimaryColor,
            //                 fontFamily: "Raleway",
            //                 fontSize: getProportionateScreenWidth(15),
            //                 fontWeight: FontWeight.w600),
            //           ),
            //           WidgetSpan(
            //             child: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               size: 18,
            //               color: kPrimaryColor,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),

            //     // child: Text(
            //     //   "START YOUR FREE 3-MONTH TRIAL",
            //     //   style: TextStyle(
            //     //       // color: HexColor.fromHex('#ab965e'),
            //     //       //  Color.fromARGB(171, 150, 94, 0),
            //     //       color: Color.fromRGBO(126, 111, 85, 1),
            //     //       fontSize: getProportionateScreenWidth(15),
            //     //       fontWeight: FontWeight.w800),
            //     // ),
            //   ),
            // ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Center(
              child: Text(
                "No commitment for 3 months-cancel anytime",
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
