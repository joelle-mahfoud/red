import 'package:flutter/material.dart';
// import 'package:redcircleflutter/screens/sign_up/sign_up_screen.dart';
import '../size_config.dart';

class HyperLink extends StatelessWidget {
  const HyperLink({
    Key key,
    this.title,
    this.press,
    this.titleColor,
    this.fontsize,
    this.fontweight,
  }) : super(key: key);

  final String title;
  final Color titleColor;
  final Function press;
  final double fontsize;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: press,
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontsize ?? getProportionateScreenWidth(18),
                color: titleColor,
                decoration: TextDecoration.underline,
                fontWeight: fontweight ?? FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
