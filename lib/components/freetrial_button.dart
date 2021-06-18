import 'package:flutter/material.dart';

// import '../constants.dart';
import '../constants.dart';
import '../size_config.dart';

class FreeTrialButton extends StatelessWidget {
  const FreeTrialButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        // height: getProportionateScreenHeight(360),

        // padding: EdgeInsets.symmetric(
        //     vertical:
        //         getProportionateScreenWidth(SizeConfig.screenWidth * 0.03),
        //     horizontal:
        //         getProportionateScreenHeight(SizeConfig.screenHeight * 0.12)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(0)),
          border: Border.all(color: KBorderColor, width: 0.4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
          ),
        ),
      ),
    );
  }
}
