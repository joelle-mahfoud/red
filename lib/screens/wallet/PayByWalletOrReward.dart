import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/Exit.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/models/UserRewards.dart';
import 'package:redcircleflutter/models/clientReward.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/screens/request/request.dart';
import 'package:redcircleflutter/screens/wallet/component/HistoryRewardsGrid.dart';
import 'package:redcircleflutter/screens/wallet/component/HistoryWalletsGrid.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PayByWalletOrReward extends StatefulWidget {
  final String packageid, totalPrice, orderId;
  final bool isToPackage;
  const PayByWalletOrReward(
      {Key key,
      this.isToPackage,
      this.packageid,
      this.orderId,
      this.totalPrice})
      : super(key: key);

  @override
  _PayByWalletOrRewardState createState() => _PayByWalletOrRewardState();
}

class _PayByWalletOrRewardState extends State<PayByWalletOrReward> {
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
          if (rewardpoint >= double.parse(widget.totalPrice)) {
            canUseReward = true;
          }
          if (walletAmount >= double.parse(widget.totalPrice)) {
            canUseWallet = true;
          }
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

  double amountEarned = 0;
  String error = "";
  bool canUseWallet = false;
  bool canUseReward = false;
  bool isDone = false;
  ClientReward clientRewards;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: kPrimaryColor,
              height: .5,
              width: getProportionateScreenWidth(SizeConfig.screenWidth * 0.9),
            ),
            preferredSize: Size.fromHeight(4.0)),
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          "Pay By",
          style: TextStyle(
              color: kPrimaryColor, fontSize: getProportionateScreenHeight(23)),
        ),
        toolbarHeight: getProportionateScreenHeight(100),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
            iconSize: getProportionateScreenHeight(35),
            onPressed: () {
              if (!isDone && !widget.isToPackage) {
                KeyboardUtil.hideKeyboard(context);
                Navigator.of(context).pop();
              }
            }),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.all(5)),
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
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 18),
                          //     ),
                          //     Text(
                          //       "€" + (walletAmount ?? 0).toString(),
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 18),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.01),
                          ),
                          Row(
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
                          Visibility(
                            visible: !isDone,
                            child: Text(
                              "Amount to pay: €" + widget.totalPrice,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.04),
                          ),
                          Text(
                            "When you spend credit. it will appear here",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white30, fontSize: 18),
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(
                                  SizeConfig.screenHeight * 0.02)),
                          Visibility(
                            visible: !isDone,
                            // child: AbsorbPointer(
                            //   absorbing: !canUseWallet,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  error = "";
                                });
                                if (!canUseWallet) {
                                  setState(() {
                                    error =
                                        "You cannot pay by wallet ,Because the value paid is greater than the value of your wallet. ";
                                  });
                                  return;
                                }
                                bool shouldUpdate = await showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                            'Wallet',
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          content: Text(
                                            'Are you sure you want pay by wallet?',
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
                                              onPressed: () async {
                                                if (widget.isToPackage) {
                                                  addWallet(0, "0",
                                                          widget.totalPrice)
                                                      .then((value) {
                                                    if (value != null &&
                                                        value.result == 1) {
                                                      addClientPackage(
                                                              widget.packageid)
                                                          .then((value1) {
                                                        if (value1 != null) {
                                                          Navigator.pop(
                                                              context, true);
                                                        } else {
                                                          Navigator.pop(
                                                              context, false);
                                                        }
                                                      });
                                                    } else {
                                                      Navigator.pop(
                                                          context, false);
                                                    }
                                                  });
                                                } else {
                                                  addWallet(0, widget.orderId,
                                                          widget.totalPrice)
                                                      .then((value) {
                                                    if (value != null) {
                                                      onAddClientRewards(
                                                              widget.orderId,
                                                              widget.totalPrice)
                                                          .then((value1) {
                                                        if (value1 != null &&
                                                            value1.result ==
                                                                1) {
                                                          amountEarned =
                                                              value1.amount;
                                                          Navigator.pop(
                                                              context, true);
                                                        } else {
                                                          Navigator.pop(
                                                              context, false);
                                                        }
                                                      });
                                                    } else {
                                                      Navigator.pop(
                                                          context, false);
                                                    }
                                                  });
                                                }
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
                                  if (widget.isToPackage) {
                                    Navigator.pushNamed(
                                        context, HomeScreen.routeName);
                                  } else {
                                    if (amountEarned != 0) {
                                      await showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                  'Reward',
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                                content: Text(
                                                  'You earned ' +
                                                      amountEarned.toString() +
                                                      " €",
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                                elevation: 100,
                                                backgroundColor:
                                                    KBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: kPrimaryColor
                                                            .withOpacity(0.8)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, false),
                                                    child: Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: kPrimaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    }
                                  }
                                  futureUserRewards = fetchUserRewards();
                                  setState(() {
                                    isDone = true;
                                  });
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
                                        child: Icon(
                                          Icons.wallet_travel,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Wallet",
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
                            // ),
                          ),
                          Visibility(
                            visible: !isDone,
                            child: SizedBox(
                                height: getProportionateScreenHeight(
                                    SizeConfig.screenHeight * 0.02)),
                          ),
                          // AbsorbPointer(
                          //   absorbing: !canUseReward,child:
                          Visibility(
                            visible: !isDone,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  error = "";
                                });
                                if (!canUseReward) {
                                  setState(() {
                                    error =
                                        "You cannot pay by wallet ,Because the value paid is greater than the value of your rewards. ";
                                  });
                                  return;
                                }
                                bool shouldUpdate = await showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                            'Reward',
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          content: Text(
                                            'Are you sure you want pay by your rewards?',
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
                                              // style: ButtonStyle(
                                              //     backgroundColor:
                                              //         MaterialStateProperty.all(
                                              //             Color.fromRGBO(
                                              //                 42, 63, 84, 1))),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                            TextButton(
                                              // style: ButtonStyle(
                                              //     backgroundColor:
                                              //         MaterialStateProperty.all(
                                              //             Color.fromRGBO(
                                              //                 42, 63, 84, 1))),
                                              onPressed: () async {
                                                if (widget.isToPackage) {
                                                  addUsedRewards("0",
                                                          widget.totalPrice)
                                                      .then((value) {
                                                    if (value != null) {
                                                      addClientPackage(
                                                              widget.packageid)
                                                          .then((value) {
                                                        if (value == true) {
                                                          Navigator.pop(
                                                              context, true);
                                                        } else {
                                                          Navigator.pop(
                                                              context, false);
                                                        }
                                                      });
                                                    } else {
                                                      Navigator.pop(
                                                          context, false);
                                                    }
                                                  });
                                                } else {
                                                  bool res =
                                                      await onAddUsedRewards(
                                                          widget.orderId,
                                                          widget.totalPrice);
                                                  if (res)
                                                    Navigator.of(context)
                                                        .pop(true);
                                                }
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
                                  if (widget.isToPackage) {
                                    Navigator.pushNamed(
                                        context, HomeScreen.routeName);
                                  } else {
                                    futureUserRewards = fetchUserRewards();
                                    setState(() {
                                      isDone = true;
                                    });
                                  }
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
                                  color: kPrimaryColor.withOpacity(0.5),
                                  border: Border.all(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      width: 0.8),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.redeem,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Reward",
                                        style: TextStyle(
                                            color: Colors.white,
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
                          ),

                          Visibility(
                            visible: (isDone & !widget.isToPackage),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  )),
                              child: Container(
                                // height: getProportionateScreenWidth(50),
                                width: getProportionateScreenWidth(
                                    SizeConfig.screenWidth * 0.85),
                                padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(
                                        SizeConfig.screenHeight * 0.02)),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.5),
                                  border: Border.all(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      width: 0.8),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.done,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Done",
                                        style: TextStyle(
                                            color: Colors.white,
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
                          ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.1),
                    ),
                    Visibility(
                      visible: !isDone,
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
