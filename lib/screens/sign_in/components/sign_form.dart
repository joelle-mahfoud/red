import 'package:flutter/material.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/components/login_button.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  // @override
  // void initState() {
  //   _passwordVisible = false;
  // }

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
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
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: SizedBox(
        child: Container(
          padding: EdgeInsets.only(
              left:
                  getProportionateScreenHeight(SizeConfig.screenHeight * 0.02),
              right:
                  getProportionateScreenWidth(SizeConfig.screenWidth * 0.02)),
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.02)),
              buildPasswordFormField(),
              // SizedBox(
              //     height: getProportionateScreenWidth(
              //         SizeConfig.screenHeight * 0.02)),
              FormError(errors: errors),
              LoginButton(
                  text: "LOGIN >",
                  press: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      dynamic res = await login(email, password);
                      if (res[0]) {
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else {
                        print(res[1]);
                        addError(error: res[1]);
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  bool _passwordVisible = false;
  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: !_passwordVisible, //This will obscure text dynamically
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        // else if (value.length < 8) {
        //   addError(error: kShortPassError);
        //   return "";
        // }
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
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        // suffixIcon: IconButton(
        //   icon: Icon(
        //     // Based on passwordVisible state choose the icon
        //     _passwordVisible ? Icons.visibility : Icons.visibility_off,
        //     color: Theme.of(context).primaryColorDark,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       _passwordVisible = !_passwordVisible;
        //     });
        //   },
        // ),
      ),
    );
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
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
