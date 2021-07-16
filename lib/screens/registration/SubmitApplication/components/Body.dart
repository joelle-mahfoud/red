import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';
import 'package:redcircleflutter/size_config.dart';

import 'SubmitForm.dart';

class Body extends StatelessWidget {
  final Membership membership;
  Body({Key key, this.membership}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                getProportionateScreenWidth(SizeConfig.screenWidth * 0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SubmitForm(membership: membership),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
