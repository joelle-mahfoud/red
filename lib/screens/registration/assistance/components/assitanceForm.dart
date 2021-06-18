import 'package:flutter/material.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class AssitanceForm extends StatefulWidget {
  @override
  _AssitanceFormState createState() => _AssitanceFormState();
}

class _AssitanceFormState extends State<AssitanceForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          height: getProportionateScreenHeight(SizeConfig.screenHeight * 0.5),
          // height: getProportionateScreenHeight(
          //                 SizeConfig.screenHeight * 50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   flex: 1,
              // child: SingleChildScrollView(
              // child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.02)),
                  buildEmailFormField(),
                  SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.02)),
                  buildPhoneFormField(),
                  SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.02)),
                  buildMessageFormField(),
                  SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.02)),
                  FormError(errors: errors),
                ],
              ),
              // ),
              // ),
              SizedBox(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.05)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  // height: getProportionateScreenHeight(
                  //     SizeConfig.screenHeight * 0.07),
                  width: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.85),
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.02)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: KBorderColor,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "SEND   ",
                          style: TextStyle(
                              color: Color.fromRGBO(22, 22, 23, 0.8),
                              fontFamily: "Raleway",
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.w600),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 18,
                            color: Color.fromRGBO(22, 22, 23, 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: KBorderColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow.withOpacity(0.3)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: "Email Address",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: KBorderColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow.withOpacity(0.3)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: "Phone Number",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField buildMessageFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      style: TextStyle(color: Colors.white),
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: KBorderColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow.withOpacity(0.3)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: "Message",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
