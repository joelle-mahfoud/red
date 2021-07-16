import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/screens/account/privacyPolicy.dart';
import 'package:redcircleflutter/screens/account/termsConditions.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/screens/wallet/PayByWalletOrReward.dart';
import 'package:redcircleflutter/size_config.dart';

class SubmitApplicationWithoutRegisteration extends StatefulWidget {
  final String packageid, totalPrice;
  const SubmitApplicationWithoutRegisteration(
      {Key key, this.packageid, this.totalPrice})
      : super(key: key);

  @override
  _SubmitApplicationWithoutRegisterationState createState() =>
      _SubmitApplicationWithoutRegisterationState();
}

class _SubmitApplicationWithoutRegisterationState
    extends State<SubmitApplicationWithoutRegisteration> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "SUBMIT \nAPPLICATION",
          textAlign: TextAlign.center,
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
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.03)),
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
                                              text: '', //'Black Membership',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    251, 255, 255, 1),
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        16),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      'Continuing you agree to RED CIRCLE\'s ',
                                                  // ' plan is a 12 month contact.By Continuing you agree to RED CIRCLE\'s ',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        251, 255, 255, 1),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Terms and Conditions',
                                                  recognizer:
                                                      new TapGestureRecognizer()
                                                        ..onTap = () => {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              TermsCondictions()))
                                                            },
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color.fromRGBO(
                                                        251, 255, 255, 1),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' and confirm that you have read RED CIRCLE\'s\n',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        251, 255, 255, 1),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Privacy Policy',
                                                  recognizer:
                                                      new TapGestureRecognizer()
                                                        ..onTap = () => {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Privacypolicy()))
                                                            },
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color.fromRGBO(
                                                        251, 255, 255, 1),
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                      style: TextStyle(
                                                          color: kPrimaryColor),
                                                    ),
                                                    content: Text(
                                                      'Are you sure you want to pay?',
                                                      style: TextStyle(
                                                          color: kPrimaryColor),
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
                                                        // style: ButtonStyle(
                                                        //     backgroundColor:
                                                        //         MaterialStateProperty.all(
                                                        //             Color.fromRGBO(
                                                        //                 42, 63, 84, 1))),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        // Navigator.of(context).pop(),
                                                        child: Text(
                                                          'No',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        // style: ButtonStyle(
                                                        //     backgroundColor:
                                                        //         MaterialStateProperty.all(
                                                        //             Color.fromRGBO(
                                                        //                 42, 63, 84, 1))),
                                                        onPressed: () async {
                                                          addWallet(
                                                                  0,
                                                                  "0",
                                                                  widget
                                                                      .totalPrice)
                                                              .then((value) {
                                                            if (value != null) {
                                                              addClientPackage(
                                                                      widget
                                                                          .packageid)
                                                                  .then(
                                                                      (value) {
                                                                if (value ==
                                                                    true) {
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                } else {
                                                                  Navigator.pop(
                                                                      context,
                                                                      false);
                                                                }
                                                              });
                                                            } else {
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                            }
                                                          });
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
                                            Navigator.pushNamed(
                                                context, HomeScreen.routeName);
                                          }
                                        },
                                        child: Container(
                                          // height: getProportionateScreenWidth(50),
                                          width: getProportionateScreenWidth(
                                              SizeConfig.screenWidth * 0.85),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  getProportionateScreenHeight(
                                                      SizeConfig.screenHeight *
                                                          0.02)),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    const Radius.circular(5.0)),
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Image(
                                                    height: 20,
                                                    width: 26,
                                                    image: AssetImage(
                                                        'assets/images/pay.png'),
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
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              15),
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PayByWalletOrReward(
                                                  packageid: widget.packageid,
                                                  isToPackage: true,
                                                  orderId: "0",
                                                  totalPrice: widget.totalPrice,
                                                ),
                                              ));

                                          // showDialog(
                                          //     context: context,
                                          //     barrierDismissible: true,
                                          //     builder: (context) => AlertDialog(
                                          //           title: Text(
                                          //             'Wallet',
                                          //             style: TextStyle(
                                          //                 color: kPrimaryColor),
                                          //           ),
                                          //           content: Text(
                                          //             'Are you sure ?',
                                          //             style: TextStyle(
                                          //                 color: kPrimaryColor),
                                          //           ),
                                          //           elevation: 100,
                                          //           backgroundColor:
                                          //               KBackgroundColor,
                                          //           shape: RoundedRectangleBorder(
                                          //               side: BorderSide(
                                          //                   color: kPrimaryColor
                                          //                       .withOpacity(
                                          //                           0.8)),
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                       Radius.circular(
                                          //                           10.0))),
                                          //           actions: <Widget>[
                                          //             TextButton(
                                          //               // style: ButtonStyle(
                                          //               //     backgroundColor:
                                          //               //         MaterialStateProperty.all(
                                          //               //             Color.fromRGBO(
                                          //               //                 42, 63, 84, 1))),
                                          //               onPressed: () =>
                                          //                   Navigator.of(
                                          //                           context)
                                          //                       .pop(),
                                          //               child: Text(
                                          //                 'No',
                                          //                 style: TextStyle(
                                          //                     color:
                                          //                         kPrimaryColor),
                                          //               ),
                                          //             ),
                                          //             TextButton(
                                          //               // style: ButtonStyle(
                                          //               //     backgroundColor:
                                          //               //         MaterialStateProperty.all(
                                          //               //             Color.fromRGBO(
                                          //               //                 42, 63, 84, 1))),
                                          //               onPressed: () => {
                                          //                 Navigator.push(
                                          //                     context,
                                          //                     MaterialPageRoute(
                                          //                       builder:
                                          //                           (context) =>
                                          //                               PayByWalletOrReward(),
                                          //                     )),

                                          //                 // Navigator.of(context)
                                          //                 //     .pop(),
                                          //                 // addClientPackage(widget
                                          //                 //         .packageid)
                                          //                 //     .then((value) {
                                          //                 //   if (value == true)
                                          //                 //     Navigator.pushNamed(
                                          //                 //         context,
                                          //                 //         HomeScreen
                                          //                 //             .routeName);
                                          //                 // }),
                                          //               },
                                          //               child: Text(
                                          //                 'Yes',
                                          //                 style: TextStyle(
                                          //                     color:
                                          //                         kPrimaryColor),
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ));
                                        },
                                        child: Container(
                                          // height: getProportionateScreenWidth(50),
                                          width: getProportionateScreenWidth(
                                              SizeConfig.screenWidth * 0.85),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  getProportionateScreenHeight(
                                                      SizeConfig.screenHeight *
                                                          0.02)),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    171, 150, 94, 1),
                                                width: 0.8),
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .call_to_action_rounded,
                                                    size: 18,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " Wallet",
                                                  style: TextStyle(
                                                      color: kPrimaryColor,
                                                      fontFamily: "Raleway",
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              15),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.1)),
                                      // InkWell(
                                      //   onTap: () =>
                                      //       Navigator.pushNamed(context, Assistance.routeName),
                                      //   child: Text(
                                      //     "Require assistance?",
                                      //     style: TextStyle(
                                      //       fontSize: getProportionateScreenWidth(15),
                                      //       color: Colors.white,
                                      //       decoration: TextDecoration.underline,
                                      //     ),
                                      //   ),
                                      // ),
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
