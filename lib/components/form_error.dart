import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: getProportionateScreenWidth(SizeConfig.screenHeight * 0.02),
          width: getProportionateScreenWidth(SizeConfig.screenHeight * 0.02),
        ),
        SizedBox(
          width: getProportionateScreenWidth(SizeConfig.screenHeight * 0.01),
        ),
        Text(error, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
