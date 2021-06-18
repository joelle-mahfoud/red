import 'package:flutter/material.dart';
import '../size_config.dart';

class RedCircleText extends StatelessWidget {
  const RedCircleText({
    Key key,
    this.sizetext,
    this.sizeC,
  }) : super(key: key);
  final double sizetext;
  final double sizeC;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'RED',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(sizetext),
                color: Color.fromRGBO(180, 1, 15, 1)),
          ),
          Text('C',
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(sizeC),
                  color: Color.fromRGBO(180, 1, 15, 1))),
          Text(
            'IRCLE',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(sizetext),
                color: Color.fromRGBO(180, 1, 15, 1)),
          ),
        ],
      ),
    );
  }
}
