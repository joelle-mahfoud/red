import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/models/UserRewards.dart';
import 'package:redcircleflutter/screens/wallet/component/HistoryRewardsGrid.dart';
import 'package:redcircleflutter/screens/wallet/component/HistoryWalletsGrid.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletAndRewards extends StatefulWidget {
  const WalletAndRewards({Key key}) : super(key: key);

  @override
  _WalletAndRewardsState createState() => _WalletAndRewardsState();
}

class _WalletAndRewardsState extends State<WalletAndRewards> {
  Future<UserRewards> futureUserRewards;
  Future<UserRewards> fetchUserRewards() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    //{{url}}/get_user_rewards.php?token={{token}}&client_id=6
    String url = root +
        "/" +
        const_get_user_rewards +
        "?token=" +
        token +
        "&client_id=" +
        clientId.toString();
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        UserRewards userRewards = UserRewards.fromJson(res);
        setState(() {
          rewardpoint = userRewards.rewardpoint;
          walletAmount = userRewards.walletAmount;
          amountInitialValue = "";
        });
        return userRewards;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
  }

  double rewardpoint = 0;
  double walletAmount = 0;

  @override
  void initState() {
    futureUserRewards = fetchUserRewards();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  String amount;
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

  final TextEditingController textEditingController =
      new TextEditingController();
  String amountInitialValue = "";
  TextFormField buildAmountFormField() {
    return TextFormField(
      controller: textEditingController,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
      ],
      // initialValue: amountInitialValue,
      onSaved: (newValue) => amount = newValue,
      onChanged: (value) {
        // amount = double.parse(value),
        if (value.isNotEmpty) {
          removeError(error: kAmountNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAmountNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
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
        hintText: "Enter Amount",
        suffixIcon: Text(
          "(€)",
          style: TextStyle(color: Colors.white),
        ),
        suffixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                getProportionateScreenWidth(SizeConfig.screenWidth * 0.03)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.03),
              ),
              Text(
                "TOTAL CREDIT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "€" +
                    ((walletAmount == null ? 0 : walletAmount) +
                            (rewardpoint == null ? 0 : rewardpoint))
                        .toString(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.04),
              ),
              Container(
                width: getProportionateScreenWidth(250),
                child: Column(
                  children: [
                    (walletAmount == null || walletAmount == 0)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "CASH CREDIT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "€ 0.0",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HistoryWalletsGrid(),
                                      ));
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(EdgeInsets.all(5)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            KBackgroundColor)),
                                icon: Icon(
                                  Icons.history,
                                  color: kPrimaryColor,
                                ),
                                label: Text(
                                  "CASH CREDIT",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18),
                                ),
                              ),
                              Text(
                                "€" + (walletAmount ?? 0).toString(),
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                              ),
                            ],
                          ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "CASH CREDIT",
                    //       style: TextStyle(color: Colors.white, fontSize: 18),
                    //     ),
                    //     Text(
                    //       "€" + (walletAmount ?? 0).toString(),
                    //       style: TextStyle(color: Colors.white, fontSize: 18),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.01),
                    ),
                    (rewardpoint == null || rewardpoint == 0)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "REWARDS",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                              ),
                              Text(
                                "€ 0.0",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HistoryRewardsGrid(),
                                      ));
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(EdgeInsets.all(5)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            KBackgroundColor)),
                                icon: Icon(
                                  Icons.history,
                                  color: kPrimaryColor,
                                ),
                                label: Text(
                                  "REWARDS",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18),
                                ),
                              ),
                              Text(
                                "€" + (rewardpoint ?? 0).toString(),
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.04),
                    ),
                    Text(
                      "When you spend or receive credit. it will appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white30, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.05),
              ),
              Text(
                "TOP UP CASH CREDIT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.05),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: getProportionateScreenWidth(
                                SizeConfig.screenWidth * 0.24),
                            left: getProportionateScreenWidth(
                                SizeConfig.screenWidth * 0.24)),
                        child: buildAmountFormField(),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  errors.clear();
                                });
                                KeyboardUtil.hideKeyboard(context);

                                bool shouldUpdate = await showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                            'Confirmation',
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          elevation: 100,
                                          backgroundColor: KBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: kPrimaryColor
                                                      .withOpacity(0.8)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => {
                                                addWallet(1, "0", amount)
                                                    .then((value) {
                                                  if (value != null)
                                                    Navigator.pop(
                                                        context, true);
                                                  else {
                                                    Navigator.pop(
                                                        context, false);
                                                  }
                                                }),
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                          ],
                                        ));
                                if (shouldUpdate) {
                                  textEditingController.clear();
                                  futureUserRewards = fetchUserRewards();
                                }
                              }
                            },
                            child: Container(
                              height: getProportionateScreenWidth(50),
                              width: getProportionateScreenWidth(
                                  SizeConfig.screenWidth * 0.3),
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
                                    //
                                    WidgetSpan(
                                      child: Image(
                                        height: 20,
                                        width: 26,
                                        image:
                                            AssetImage('assets/images/pay.png'),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Pay",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Raleway",
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "or",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  errors.clear();
                                });
                                KeyboardUtil.hideKeyboard(context);

                                bool shouldUpdate = await showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                            'Confirmation',
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          elevation: 100,
                                          backgroundColor: KBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: kPrimaryColor
                                                      .withOpacity(0.8)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => {
                                                addWallet(1, "0", amount)
                                                    .then((value) {
                                                  if (value != null)
                                                    Navigator.pop(
                                                        context, true);
                                                  else {
                                                    Navigator.pop(
                                                        context, false);
                                                  }
                                                }),
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                          ],
                                        ));
                                if (shouldUpdate) {
                                  textEditingController.clear();
                                  futureUserRewards = fetchUserRewards();
                                }
                              }
                            },
                            child: Container(
                              height: getProportionateScreenWidth(50),
                              width: getProportionateScreenWidth(
                                  SizeConfig.screenWidth * 0.3),
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
                                      text: " Card",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: "Raleway",
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
