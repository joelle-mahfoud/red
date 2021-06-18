import 'package:flutter/material.dart';

// import '../constants.dart';
import '../size_config.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
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
        width: getProportionateScreenWidth(100),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
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
