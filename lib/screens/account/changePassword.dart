import 'package:flutter/material.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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

  String serverError;
  String oldPassword;
  String password;
  String confirmPassword;
  final _formKey = GlobalKey<FormState>();

  bool _oldPasswordVisible = false;
  TextFormField buildOldPassFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_oldPasswordVisible,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        oldPassword = value;
        if (value.isNotEmpty) {
          removeError(error: kOldPasswordNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kOldPasswordNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: EdgeInsets.all(3),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        hintText: "Old Password",
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey, // Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _oldPasswordVisible = !_oldPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  bool _passwordVisible = false;
  TextFormField buildPassFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_passwordVisible,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty) {
          removeError(error: kPasswordWeakError);
          removeError(error: kPasswordNullError);
          removeError(error: kmatchConfirmPasswordNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPasswordNullError);
          return "";
        }
        if (value.length < 6) {
          addError(error: kPasswordWeakError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: EdgeInsets.all(3),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        hintText: "New Password",
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey, // Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  bool _confirmPasswordVisible = false;
  TextFormField buildComdirmPassFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_confirmPasswordVisible,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kConfirmPasswordNullError);
          removeError(error: kmatchConfirmPasswordNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kConfirmPasswordNullError);
          return "";
        }
        if (value != password) {
          addError(error: kmatchConfirmPasswordNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        hintText: "Confirm Password",
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey, // Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: KBackgroundColor,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.03)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Form(
                        key: _formKey,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      SizeConfig.screenHeight * 0.01)),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildOldPassFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildPassFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildComdirmPassFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      FormError(errors: errors),
                                      InkWell(
                                        onTap: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();

                                            setState(() {
                                              errors.clear();
                                            });
                                            KeyboardUtil.hideKeyboard(context);

                                            bool shouldUpdate =
                                                await showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Confirmation',
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                              content: Text(
                                                                'Are you sure you want to change password?',
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                              elevation: 100,
                                                              backgroundColor:
                                                                  KBackgroundColor,
                                                              shape: RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      color: kPrimaryColor
                                                                          .withOpacity(
                                                                              0.8)),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          false),
                                                                  child: Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async =>
                                                                          {
                                                                    changePass(
                                                                            oldPassword,
                                                                            password)
                                                                        .then(
                                                                            (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        Navigator.pop(
                                                                            context,
                                                                            true);
                                                                        logOut().then((value) =>
                                                                            {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => SignInScreen(),
                                                                                  ))
                                                                            });
                                                                      } else {
                                                                        serverError =
                                                                            value;
                                                                        addError(
                                                                            error:
                                                                                serverError);
                                                                        Navigator.pop(
                                                                            context,
                                                                            false);
                                                                      }
                                                                    }),
                                                                  },
                                                                  child: Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor),
                                                                  ),
                                                                ),
                                                              ],
                                                            ));
                                            if (shouldUpdate) {
                                              Navigator.pushNamed(context,
                                                  HomeScreen.routeName);
                                            }
                                          }
                                        },
                                        child: Container(
                                          // height: getProportionateScreenHeight(
                                          //     SizeConfig.screenHeight * 0.07),
                                          width: getProportionateScreenWidth(
                                              SizeConfig.screenWidth * 0.85),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  getProportionateScreenHeight(
                                                      SizeConfig.screenHeight *
                                                          0.02)),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: KBorderColor,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "SAVE   ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          22, 22, 23, 0.8),
                                                      fontFamily: "Raleway",
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              15),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 18,
                                                    color: Color.fromRGBO(
                                                        22, 22, 23, 0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
