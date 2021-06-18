import 'package:flutter/material.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/request/components/booked.dart';
import 'package:redcircleflutter/screens/request/components/requested.dart';
import 'package:redcircleflutter/screens/request/components/topay.dart';

class RequestTabs extends StatefulWidget {
  RequestTabs({Key key}) : super(key: key);

  @override
  _RequestTabsState createState() => _RequestTabsState();
}

class _RequestTabsState extends State<RequestTabs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kTabPages = <Widget>[
      Booked(),
      ToPay(),
      Requested(),
    ];
    final kTabs = <Tab>[
      const Tab(
        child: Text(
          "BOOKED",
          style: TextStyle(fontSize: 17),
        ),
      ),
      const Tab(
        child: Text(
          "TO PAY",
          style: TextStyle(fontSize: 17),
          // style: TextStyle(color: kPrimaryColor),
        ),
      ),
      const Tab(
        child: Text(
          "REQUESTED",
          style: TextStyle(fontSize: 17),
          // style: TextStyle(color: kPrimaryColor),
        ),
      )
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KBackgroundColor,
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
          flexibleSpace: TabBar(
            // controller: _tabController,
            // isScrollable: true,
            unselectedLabelColor: Colors.white,
            labelColor: kPrimaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelPadding: EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
            )),
            tabs: kTabs,
          ),
        ),

        // appBar: AppBar(
        //   title: Text("Title"),
        //   bottom: TabBar(
        //     tabs: _KTabs,
        //   ),
        // ),
        body: TabBarView(children: kTabPages),
      ),
    );
  }
}
