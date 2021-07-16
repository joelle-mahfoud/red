import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/account/privacyPolicy.dart';
import 'package:redcircleflutter/screens/account/termsConditions.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/screens/registration/assistance/assistance.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SubmitForm extends StatefulWidget {
  final Membership membership;
  SubmitForm({Key key, this.membership}) : super(key: key);

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  final _formKey = GlobalKey<FormState>();
  Future<bool> registration(Membership membership) async {
    //"http://192.168.0.112:8383/redcircle/web/api/createuser.php?token=rb115oc-Rcas|Kredcircleu&fname=jalal&lname=jalal&dob=2020-12-16&email=jalal@hotmail.com&password=123&country_id=1&company_name=daily&position=poor"),
    dynamic response;
    print(root +
        "/" +
        const_registration +
        "?token=" +
        token +
        "&fname=" +
        membership.fname +
        "&lname=" +
        membership.lname +
        "&dob=" +
        membership.dob +
        "&email=" +
        membership.email +
        "&password=" +
        membership.password +
        "&country_id=" +
        membership.country.toString() +
        "&company_name=" +
        membership.companyName +
        "&position=" +
        membership.position +
        "&reference=" +
        membership.reference +
        "&userinterests=" +
        membership.userinterests +
        "&pakage_id=" +
        membership.packageid);

    try {
      response = await http.post(
        Uri.parse(root +
            "/" +
            const_registration +
            "?token=" +
            token +
            "&fname=" +
            membership.fname +
            "&lname=" +
            membership.lname +
            "&dob=" +
            membership.dob +
            "&email=" +
            membership.email +
            "&password=" +
            membership.password +
            "&country_id=" +
            membership.country.toString() +
            "&company_name=" +
            membership.companyName +
            "&position=" +
            membership.position +
            "&reference=" +
            membership.reference +
            "&userinterests=" +
            membership.userinterests +
            "&pakage_id=" +
            membership.packageid),
        headers: {"Accept": "application/json"},
      );
    } catch (e) {
      print(e);
    }
    print(" ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['result'] == 1) {
        try {
          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.setString(
              kfnamePrefKey,
              membership.fname[0].toUpperCase() +
                  (membership.fname.length > 1
                      ? membership.fname.substring(1)
                      : ""));
          await _pref.setString(kEmailPrefKey, membership.email);
          await _pref.setString(kPassPrefKey, membership.password);
          await _pref.setString(kclientIdPrefKey, res['user_id'].toString());
          return true;
        } catch (e) {
          return true;
        }
      } else {
        print(" ${res['message']}");
        return false;
      }
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.01)),
                      Text(
                        "STEP 3 OF 3",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.04)),
                      Text(
                        "SELECT YOUR PAYMENT METHOD",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.04)),
                      Text(
                        "Review Your Order",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              //text: widget.membership.packageid + 'Black Membership',
                              text: '', // 'Black Membership',
                              style: TextStyle(
                                color: Color.fromRGBO(251, 255, 255, 1),
                                fontSize: getProportionateScreenWidth(16),
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'Continuing you agree to RED CIRCLE\'s ',
                                  //' plan is a 12 month contact.By Continuing you agree to RED CIRCLE\'s ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(251, 255, 255, 1),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsCondictions()))
                                        },
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(251, 255, 255, 1),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' and confirm that you have read RED CIRCLE\'s\n',
                                  style: TextStyle(
                                    color: Color.fromRGBO(251, 255, 255, 1),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Privacypolicy()))
                                        },
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(251, 255, 255, 1),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ])),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.1)),
                      InkWell(
                        onTap: () async {
                          bool shouldUpdate = await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      'Pay',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    content: Text(
                                      'Are you sure you want to pay?',
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
                                        // style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             Color.fromRGBO(
                                        //                 42, 63, 84, 1))),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        // Navigator.of(context).pop(),
                                        child: Text(
                                          'No',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        // style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             Color.fromRGBO(
                                        //                 42, 63, 84, 1))),
                                        onPressed: () async {
                                          registration(widget.membership)
                                              .then((value) {
                                            if (value == true) {
                                              Navigator.pop(context, true);
                                            } else
                                              Navigator.pop(context, false);
                                          });
                                        },
                                        child: Text(
                                          'Yes',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                    ],
                                  ));
                          if (shouldUpdate) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                            // Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        },
                        child: Container(
                          // height: getProportionateScreenWidth(50),
                          width: getProportionateScreenWidth(
                              SizeConfig.screenWidth * 0.85),
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(
                                  SizeConfig.screenHeight * 0.02)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0)),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Image(
                                    height: 20,
                                    width: 26,
                                    image: AssetImage('assets/images/pay.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  // child: Icon(
                                  //   Icons.ac_unit_outlined,
                                  //   size: 18,
                                  //   color: Colors.black,
                                  // ),
                                ),
                                TextSpan(
                                  text: "Pay",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Raleway",
                                      fontSize: getProportionateScreenWidth(15),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      Text(
                        "or",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      InkWell(
                        onTap: () async {
                          bool shouldUpdate = await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      'Pay',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    content: Text(
                                      'Are you sure you want to pay By card?',
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
                                        // style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             Color.fromRGBO(
                                        //                 42, 63, 84, 1))),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        // Navigator.of(context).pop(),
                                        child: Text(
                                          'No',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        // style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             Color.fromRGBO(
                                        //                 42, 63, 84, 1))),
                                        onPressed: () async {
                                          registration(widget.membership)
                                              .then((value) {
                                            if (value == true) {
                                              Navigator.pop(context, true);
                                            } else
                                              Navigator.pop(context, false);
                                          });
                                        },
                                        child: Text(
                                          'Yes',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                    ],
                                  ));
                          if (shouldUpdate) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                            // Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        },
                        // onTap: () async {
                        //   bool shouldUpdate = await showDialog(
                        //       context: context,
                        //       barrierDismissible: true,
                        //       builder: (context) => AlertDialog(
                        //             title: Text(
                        //               'CARD',
                        //               style: TextStyle(color: kPrimaryColor),
                        //             ),
                        //             content: Text(
                        //               'Are you sure ?',
                        //               style: TextStyle(color: kPrimaryColor),
                        //             ),
                        //             elevation: 100,
                        //             backgroundColor: KBackgroundColor,
                        //             shape: RoundedRectangleBorder(
                        //                 side: BorderSide(
                        //                     color:
                        //                         kPrimaryColor.withOpacity(0.8)),
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(10.0))),
                        //             actions: <Widget>[
                        //               TextButton(
                        //                 // style: ButtonStyle(
                        //                 //     backgroundColor:
                        //                 //         MaterialStateProperty.all(
                        //                 //             Color.fromRGBO(
                        //                 //                 42, 63, 84, 1))),
                        //                 onPressed: () =>
                        //                     Navigator.of(context).pop(),
                        //                 child: Text(
                        //                   'No',
                        //                   style:
                        //                       TextStyle(color: kPrimaryColor),
                        //                 ),
                        //               ),
                        //               TextButton(
                        //                 // style: ButtonStyle(
                        //                 //     backgroundColor:
                        //                 //         MaterialStateProperty.all(
                        //                 //             Color.fromRGBO(
                        //                 //                 42, 63, 84, 1))),
                        //                 onPressed: () => {
                        //                   Navigator.of(context).pop(),
                        //                   registration(widget.membership)
                        //                       .then((value) {
                        //                     if (value == true)
                        //                       Navigator.push(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                             builder: (context) =>
                        //                                 HomeScreen(),
                        //                           ));
                        //                     // Navigator.pushNamed(context,
                        //                     //     HomeScreen.routeName);
                        //                   }),
                        //                 },
                        //                 child: Text(
                        //                   'Yes',
                        //                   style:
                        //                       TextStyle(color: kPrimaryColor),
                        //                 ),
                        //               ),
                        //             ],
                        //           ));
                        // },
                        child: Container(
                          // height: getProportionateScreenWidth(50),
                          width: getProportionateScreenWidth(
                              SizeConfig.screenWidth * 0.85),
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(
                                  SizeConfig.screenHeight * 0.02)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                color: Color.fromRGBO(171, 150, 94, 1),
                                width: 0.8),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.call_to_action_rounded,
                                    size: 18,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " CARD",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: "Raleway",
                                      fontSize: getProportionateScreenWidth(15),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.1)),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, Assistance.routeName),
                        child: Text(
                          "Require assistance?",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
