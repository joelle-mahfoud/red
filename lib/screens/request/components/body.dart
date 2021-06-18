import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/request/components/requestTabs.dart';
// import 'package:redcircleflutter/screens/registration/confirmBillingCycle/confirm_billing_cycle.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

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
              child: RequestTabs(),
            ),
          ],
        ),
      ),
    );
  }
}
