import 'package:flutter/material.dart';
import 'package:redcircleflutter/size_config.dart';
import 'AboutYouForm.dart';

class Body extends StatelessWidget {
  final String packageId;
  Body({Key key, this.packageId}) : super(key: key);
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
              child: AboutYouForm(packageId: packageId),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
