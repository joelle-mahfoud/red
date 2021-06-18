import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:redcircleflutter/screens/membership_plan/components/MembershipPlan.dart';
import 'package:redcircleflutter/screens/registration/confirmBillingCycle/confirm_billing_cycle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'Plan.dart';

class MembershipTabs extends StatefulWidget {
  MembershipTabs({Key key}) : super(key: key);

  @override
  _MembershipTabsState createState() => _MembershipTabsState();
}

class _MembershipTabsState extends State<MembershipTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  Future<int> saveIntInLocalMemory(String key, int value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
    return value;
  }

  gotoComfirmbillingCycle() async {
    saveIntInLocalMemory("plan", _tabController.index).then((value) => {
          print("plan :" + value.toString()),
          Navigator.pushNamed(context, ConfirmBillingCycle.routeName),
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MembershipPlan>>(
      future: MembershipPlan.getMembershipPlans(),
      builder: (c, s) {
        if (s.hasData) {
          List<Tab> tabs = [];
          List<Widget> _kTabPages = [];
          _tabController = TabController(
              vsync: this, initialIndex: 0, length: s.data.length);
          for (int i = 0; i < s.data.length; i++) {
            tabs.add(Tab(
              key: Key(s.data[i].id.toString()),
              child: Text(
                s.data[i].title,
                // style: TextStyle(color: Color),
              ),
            ));

            _kTabPages.add(Plan(
              urlImage: s.data[i].title,
              // itemList: s.data[i].itemList,
            ));
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: DefaultTabController(
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
                          labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                          )),
                          tabs: tabs,
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
                  ),
                ),
                InkWell(
                  onTap: () => {
                    gotoComfirmbillingCycle(),
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
                            text: "START YOUR FREE 3-MONTH TRIAL   ",
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
              ]);
        }
        if (s.hasError) print(s.error.toString());
        return Scaffold(
          body: Center(
              child: Container(
                  color: KBackgroundColor,
                  child: Text(s.hasError ? s.error.toString() : "Loading..."))),
        );
      },
    );
  }
}
