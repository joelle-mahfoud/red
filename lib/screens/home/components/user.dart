import 'package:flutter/material.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Container(
            color: KBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                Center(
                    child: Text(
                  "ACCOUNT",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w200),
                )),
                SizedBox(
                    height: getProportionateScreenWidth(
                        SizeConfig.screenHeight * 0.02)),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PROFILE",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Personal details",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Notifications",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Synchronise calendar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Membership plan",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Divider(
                            thickness: 0.1,
                            color: Colors.white,
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.03),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "SECURITY",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Change password",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Sign in with Face ID",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Divider(
                            thickness: 0.1,
                            color: Colors.white,
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.03),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "LEGAL",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Terms and Conditions",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Privacy policy",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Divider(
                            thickness: 0.1,
                            color: Colors.white,
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.03),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "SUPPORT",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Contact",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Give us feedback",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "Tell a friend",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'LogOut',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  content: Text(
                                    'Do you want to log out?',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  elevation: 100,
                                  backgroundColor: KBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              kPrimaryColor.withOpacity(0.8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async => {
                                        if (await logOut())
                                          {
                                            Navigator.pushNamed(
                                                context, SignInScreen.routeName)
                                          }
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            },
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
