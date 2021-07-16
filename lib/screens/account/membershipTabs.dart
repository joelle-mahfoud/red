import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/ArgumentsData.dart';
import 'package:redcircleflutter/models/userPlans.dart';
import 'package:redcircleflutter/screens/account/HistoryPackagesGrid.dart';
import 'package:redcircleflutter/screens/registration/SubmitApplicationWithoutRegisteration.dart';
import 'package:redcircleflutter/screens/registration/confirmBillingCycle/confirm_billing_cycle.dart';
import 'package:redcircleflutter/screens/registration/newPackage.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembershipTabs extends StatefulWidget {
  MembershipTabs({Key key}) : super(key: key);

  @override
  _MembershipTabsState createState() => _MembershipTabsState();
}

class _MembershipTabsState extends State<MembershipTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<bool> futureExistPackage;
  bool canRenewOldPackage = false;
  Future<bool> fetchExistPackage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    String url = root +
        "/" +
        const_check_renewal +
        "?token=" +
        token +
        "&client_id=" +
        clientId;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        setState(() {
          canRenewOldPackage = true;
        });
        return true;
      } else {
        print(" ${res['message']}");
        return false;
      }
    } else
      return false;
  }

  @override
  void initState() {
    super.initState();
    futureExistPackage = fetchExistPackage();
    futureUserPlan = fetchUserPlan();
  }

  Future<int> saveIntInLocalMemory(String key, int value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
    return value;
  }

  gotoComfirmbillingCycle(bool withRegistration) async {
    String cardId = _tabs[_tabController.index]
        .key
        .toString()
        .replaceAll(new RegExp(r'[^0-9]'), '');
    print("plan (key):" + cardId);
    Navigator.pushNamed(context, ConfirmBillingCycle.routeName,
        arguments: ArgumentsData(cardId, withRegistration));
  }

  bool isExpired = false;
  String packageID;
  Future<UserPlans> futureUserPlan;
  Future<UserPlans> fetchUserPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    String url = root +
        "/" +
        const_get_user_plans +
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
        List<UserPlans> services =
            (res['data'] as List).map((i) => UserPlans.fromJson(i)).toList();
        UserPlans userplan = services.first;

        packageID = userplan.package_id;
        // if (userplan.expiryDate.compareTo(DateTime.now()) < 0) {
        //   setState(() {
        //     isExpired = true;
        //   });
        // }
        return userplan;
        // .where(
        //     (element) => element.expiryDate.compareTo(DateTime.now()) > 0)
        // .first;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  List<Tab> _tabs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          "MEMBERSHIP PLANS",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPackagesGrid(),
                  ))
            },
            child: Icon(
              Icons.history,
              size: 30,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none &&
                      projectSnap.hasData == null) {
                    return Center(child: new CircularProgressIndicator());
                  } else if (projectSnap.hasData) {
                    UserPlans userPlans = projectSnap.data;
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: userPlans.titleEn + ' Membership\n',
                            style: TextStyle(
                              color: Color.fromRGBO(251, 255, 255, 1),
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              // TextSpan(
                              //   text: ' plan,\n',
                              //   style: TextStyle(
                              //     color: Color.fromRGBO(251, 255, 255, 1),
                              //     fontWeight: FontWeight.normal,
                              //   ),
                              // ),
                              TextSpan(
                                text: 'Purchased at : ' +
                                    formatter.format(userPlans.purchacedDate) +
                                    ' \n',
                                style: TextStyle(
                                  color: Color.fromRGBO(251, 255, 255, 1),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: userPlans.trial + ' month Free Trial \n',
                                style: TextStyle(
                                  color: Color.fromRGBO(251, 255, 255, 1),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: 'Expired at ' +
                                    formatter.format(userPlans.expiryDate),
                                style: TextStyle(
                                  color: (DateTime.parse(DateFormat(
                                                      "yyyy-MM-dd")
                                                  .format(userPlans.expiryDate))
                                              .compareTo(DateTime.parse(
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(
                                                          DateTime.now()))) <
                                          0)
                                      ? Colors.red
                                      : Color.fromRGBO(251, 255, 255, 1),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]));
                  }
                  return Center();
                },
                future: futureUserPlan,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none &&
                      projectSnap.hasData == null) {
                    return Center(child: new CircularProgressIndicator());
                  } else if (projectSnap.hasData) {
                    UserPlans userPlans = projectSnap.data;
                    print(DateFormat("yyyy-MM-dd").format(DateTime.now()));
                    print('-------------------  ' +
                        userPlans.expiryDate
                            .compareTo(DateTime.now())
                            .toString());
                    return Visibility(
                      // visible: true,
                      visible: (DateTime.parse(DateFormat("yyyy-MM-dd")
                                  .format(userPlans.expiryDate))
                              .compareTo(DateTime.parse(DateFormat("yyyy-MM-dd")
                                  .format(DateTime.now()))) <
                          0),
                      child: Column(
                        children: [
                          Visibility(
                            visible: canRenewOldPackage,
                            child: InkWell(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SubmitApplicationWithoutRegisteration(
                                        packageid: packageID,
                                        totalPrice: userPlans.price,
                                      ),
                                    ))
                              },
                              child: Container(
                                width: getProportionateScreenWidth(
                                    SizeConfig.screenWidth * 0.85),
                                padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenWidth(
                                        SizeConfig.screenWidth * 0.03)),
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
                                      TextSpan(
                                        text: "Renew",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontFamily: "Raleway",
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewPackage(),
                                  ))
                            },
                            child: Container(
                              width: getProportionateScreenWidth(
                                  SizeConfig.screenWidth * 0.85),
                              padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenWidth(
                                      SizeConfig.screenWidth * 0.03)),
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
                                    TextSpan(
                                      text: "New Package",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: "Raleway",
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 18,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    // Visibility(
                    //   visible:
                    //       (userPlans.expiryDate.compareTo(DateTime.now()) < 0)
                    //           ? true
                    //           : false,
                    //   // child: Column(
                    //   //   children: [
                    //   //     InkWell(
                    //   //       onTap: () => {
                    //   //         Navigator.push(
                    //   //             context,
                    //   //             MaterialPageRoute(
                    //   //               builder: (context) =>
                    //   //                   SubmitApplicationWithoutRegisteration(
                    //   //                       packageid: packageID),
                    //   //             ))
                    //   //       },
                    //   //       child: Container(
                    //   //         width: getProportionateScreenWidth(
                    //   //             SizeConfig.screenWidth * 0.85),
                    //   //         padding: EdgeInsets.symmetric(
                    //   //             vertical: getProportionateScreenWidth(
                    //   //                 SizeConfig.screenWidth * 0.03)),
                    //   //         alignment: Alignment.center,
                    //   //         decoration: BoxDecoration(
                    //   //           color: Colors.black,
                    //   //           border: Border.all(
                    //   //               color: Color.fromRGBO(171, 150, 94, 1),
                    //   //               width: 0.8),
                    //   //         ),
                    //   //         child: RichText(
                    //   //           text: TextSpan(
                    //   //             children: [
                    //   //               TextSpan(
                    //   //                 text: "Renew",
                    //   //                 style: TextStyle(
                    //   //                     color: kPrimaryColor,
                    //   //                     fontFamily: "Raleway",
                    //   //                     fontSize:
                    //   //                         getProportionateScreenWidth(15),
                    //   //                     fontWeight: FontWeight.w600),
                    //   //               ),
                    //   //               WidgetSpan(
                    //   //                 child: Icon(
                    //   //                   Icons.arrow_forward_ios_outlined,
                    //   //                   size: 18,
                    //   //                   color: kPrimaryColor,
                    //   //                 ),
                    //   //               ),
                    //   //             ],
                    //   //           ),
                    //   //         ),
                    //   //       ),
                    //   //     ),
                    //   //     Divider(
                    //   //       color: kPrimaryColor,
                    //   //       height: getProportionateScreenHeight(
                    //   //           SizeConfig.screenHeight * 0.03),
                    //   //     ),
                    //   //     InkWell(
                    //   //       onTap: () => {
                    //   //         Navigator.push(
                    //   //             context,
                    //   //             MaterialPageRoute(
                    //   //               builder: (context) => NewPackage(),
                    //   //             ))
                    //   //       },
                    //   //       child: Container(
                    //   //         width: getProportionateScreenWidth(
                    //   //             SizeConfig.screenWidth * 0.85),
                    //   //         padding: EdgeInsets.symmetric(
                    //   //             vertical: getProportionateScreenWidth(
                    //   //                 SizeConfig.screenWidth * 0.03)),
                    //   //         alignment: Alignment.center,
                    //   //         decoration: BoxDecoration(
                    //   //           color: Colors.black,
                    //   //           border: Border.all(
                    //   //               color: Color.fromRGBO(171, 150, 94, 1),
                    //   //               width: 0.8),
                    //   //         ),
                    //   //         child: RichText(
                    //   //           text: TextSpan(
                    //   //             children: [
                    //   //               TextSpan(
                    //   //                 text: "New Package",
                    //   //                 style: TextStyle(
                    //   //                     color: kPrimaryColor,
                    //   //                     fontFamily: "Raleway",
                    //   //                     fontSize:
                    //   //                         getProportionateScreenWidth(15),
                    //   //                     fontWeight: FontWeight.w600),
                    //   //               ),
                    //   //               WidgetSpan(
                    //   //                 child: Icon(
                    //   //                   Icons.arrow_forward_ios_outlined,
                    //   //                   size: 18,
                    //   //                   color: kPrimaryColor,
                    //   //                 ),
                    //   //               ),
                    //   //             ],
                    //   //           ),
                    //   //         ),
                    //   //       ),
                    //   //     ),
                    //   //   ],
                    //   // ),
                    // );
                  }
                  return Center();
                },
                future: futureUserPlan,
              ),

              // Expanded(
              //   flex: 3,
              //   child: FutureBuilder<List<CircleCards>>(
              //     future: MembershipPlan.fetchCircleCards(),
              //     builder: (c, s) {
              //       if (s.hasData) {
              //         // List<Tab> tabs = [];
              //         List<Widget> _kTabPages = [];
              //         _tabController = TabController(
              //             vsync: this, initialIndex: 0, length: s.data.length);
              //         for (int i = 0; i < s.data.length; i++) {
              //           _tabs.add(Tab(
              //             key: Key(s.data[i].id.toString()),
              //             child: Text(
              //               s.data[i].name,
              //               // style: TextStyle(color: Color),
              //             ),
              //           ));

              //           _kTabPages.add(Plan(
              //             key: ValueKey<String>(s.data[i].id),
              //             urlImage: s.data[i].image,
              //             itemList: MembershipPlan.fetchBenefits(
              //                 s.data[i].id.toString()),
              //             // itemList: s.data[i].itemList,
              //           ));
              //         }
              //         return DefaultTabController(
              //           length: s.data.length,
              //           child: Scaffold(
              //             appBar: AppBar(
              //               backgroundColor: KBackgroundColor,
              //               automaticallyImplyLeading: false,
              //               brightness: Brightness.dark,
              //               flexibleSpace: TabBar(
              //                 controller: _tabController,
              //                 // isScrollable: true,
              //                 unselectedLabelColor: Colors.white,
              //                 labelColor: kPrimaryColor,
              //                 labelStyle:
              //                     TextStyle(fontWeight: FontWeight.w500),
              //                 indicatorSize: TabBarIndicatorSize.tab,
              //                 indicator: BoxDecoration(
              //                     border: Border(
              //                   bottom: BorderSide(
              //                     width: 1,
              //                     color: kPrimaryColor,
              //                   ),
              //                 )),
              //                 tabs: _tabs,
              //               ),
              //             ),
              //             // body: TabBarView(
              //             //     controller: _tabController, children: _KTabPages),

              //             body: Listener(
              //                 onPointerDown: (PointerDownEvent event) {
              //                   timeDilation = 0.1;
              //                 },
              //                 onPointerUp: (PointerUpEvent event) {
              //                   Timer(Duration(milliseconds: 1000), () {
              //                     timeDilation = 0.1;
              //                   });
              //                 },
              //                 child: TabBarView(
              //                     controller: _tabController,
              //                     children: _kTabPages)),
              //           ),
              //         );
              //       }
              //       if (s.hasError) print(s.error.toString());
              //       return Scaffold(
              //         body: Center(
              //             child: Container(
              //                 color: KBackgroundColor,
              //                 child: Text(s.hasError
              //                     ? s.error.toString()
              //                     : "Loading..."))),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(height: SizeConfig.screenHeight * 0.04),
              // FutureBuilder(
              //   builder: (context, projectSnap) {
              //     if (projectSnap.connectionState == ConnectionState.none &&
              //         projectSnap.hasData == null) {
              //       return Center(child: new CircularProgressIndicator());
              //     } else if (projectSnap.hasData) {
              //       UserPlans userPlans = projectSnap.data;
              //       return Visibility(
              //         visible: (userPlans.expiryDate
              //                 .difference(DateTime.now())
              //                 .inDays <
              //             0),
              //         child: InkWell(
              //           onTap: () => {
              //             gotoComfirmbillingCycle(false),
              //           },
              //           child: Container(
              //             width: getProportionateScreenWidth(
              //                 SizeConfig.screenWidth * 0.85),
              //             padding: EdgeInsets.symmetric(
              //                 vertical: getProportionateScreenWidth(
              //                     SizeConfig.screenWidth * 0.03)),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: Colors.black,
              //               border: Border.all(
              //                   color: Color.fromRGBO(171, 150, 94, 1),
              //                   width: 0.8),
              //             ),
              //             child: RichText(
              //               text: TextSpan(
              //                 children: [
              //                   TextSpan(
              //                     text: "New Package",
              //                     style: TextStyle(
              //                         color: kPrimaryColor,
              //                         fontFamily: "Raleway",
              //                         fontSize: getProportionateScreenWidth(15),
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                   WidgetSpan(
              //                     child: Icon(
              //                       Icons.arrow_forward_ios_outlined,
              //                       size: 18,
              //                       color: kPrimaryColor,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     }
              //     return Center();
              //   },
              //   future: futureUserPlan,
              // ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
