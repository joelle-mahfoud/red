import 'package:flutter/material.dart';

import '../../../size_config.dart';
// import '../../../constants.dart';
import 'package:redcircleflutter/components/redcircletext.dart';

class SplashContent extends StatelessWidget {
  // const SplashContent({
  //   Key key,
  //   this.text,
  //   this.image,
  // }) : super(key: key);
  // final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 2),
        RedCircleText(sizetext: 50, sizeC: 80),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "A Private Members Lifestyle Club",
            // textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(19),
                color: Colors.white.withOpacity(0.6)),
          ),
        ),
        Spacer(flex: 2),
        SizedBox(
          child: Text(
            "By The Sun Secret collection",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.white.withOpacity(0.3)),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 15))
      ],
    );
  }
}
