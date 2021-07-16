import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/ArgumentsData.dart';
import 'package:redcircleflutter/models/about.dart';
import 'package:redcircleflutter/models/userPlans.dart';
import 'package:redcircleflutter/screens/membership_plan/components/MembershipPlan.dart';
import 'package:redcircleflutter/screens/membership_plan/components/Plan.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'confirmBillingCycle/confirm_billing_cycle.dart';
import 'package:flutter/scheduler.dart';

class NewPackage extends StatefulWidget {
  const NewPackage({Key key}) : super(key: key);

  @override
  _NewPackageState createState() => _NewPackageState();
}

class _NewPackageState extends State<NewPackage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs = [];

  @override
  void initState() {
    super.initState();
    futureUserPlan = fetchUserPlan();
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
        return userplan;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

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
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Divider(
                color: kPrimaryColor,
                height: getProportionateScreenHeight(
                    SizeConfig.screenHeight * 0.03),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder<List<CircleCards>>(
                  future: MembershipPlan.fetchCircleCards(),
                  builder: (c, s) {
                    if (s.hasData) {
                      // List<Tab> tabs = [];
                      List<Widget> _kTabPages = [];
                      _tabController = TabController(
                          vsync: this, initialIndex: 0, length: s.data.length);
                      for (int i = 0; i < s.data.length; i++) {
                        _tabs.add(Tab(
                          key: Key(s.data[i].id.toString()),
                          child: Text(
                            s.data[i].name,
                            // style: TextStyle(color: Color),
                          ),
                        ));

                        _kTabPages.add(Plan(
                          key: ValueKey<String>(s.data[i].id),
                          urlImage: s.data[i].image,
                          itemList: MembershipPlan.fetchBenefits(
                              s.data[i].id.toString()),
                          // itemList: s.data[i].itemList,
                        ));
                      }
                      return DefaultTabController(
                        length: s.data.length,
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: KBackgroundColor,
                            automaticallyImplyLeading: false,
                            brightness: Brightness.dark,
                            flexibleSpace: TabBar(
                              controller: _tabController,
                              // isScrollable: true,
                              unselectedLabelColor: Colors.white,
                              labelColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w500),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                              )),
                              tabs: _tabs,
                            ),
                          ),
                          // body: TabBarView(
                          //     controller: _tabController, children: _KTabPages),

                          body: Listener(
                              onPointerDown: (PointerDownEvent event) {
                                timeDilation = 0.1;
                              },
                              onPointerUp: (PointerUpEvent event) {
                                Timer(Duration(milliseconds: 1000), () {
                                  timeDilation = 0.1;
                                });
                              },
                              child: TabBarView(
                                  controller: _tabController,
                                  children: _kTabPages)),
                        ),
                      );
                    }
                    if (s.hasError) print(s.error.toString());
                    return Scaffold(
                      body: Center(
                          child: Container(
                              color: KBackgroundColor,
                              child: Text(s.hasError
                                  ? s.error.toString()
                                  : "Loading..."))),
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              InkWell(
                onTap: () => {
                  gotoComfirmbillingCycle(false),
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
                        color: Color.fromRGBO(171, 150, 94, 1), width: 0.8),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Next ",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: "Raleway",
                              fontSize: getProportionateScreenWidth(15),
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
              SizedBox(height: SizeConfig.screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
