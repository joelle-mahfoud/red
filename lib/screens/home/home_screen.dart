import 'package:flutter/material.dart';

import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/home/components/Chat.dart';
import 'package:redcircleflutter/screens/home/components/search.dart';
import 'package:redcircleflutter/screens/home/components/user.dart';
import 'package:redcircleflutter/screens/home/components/body.dart';
import 'package:redcircleflutter/size_config.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavPage = 0;
  final List _allNavPages = [
    Body(),
    Search(),
    FlutterChat(),
    User(),
  ];
  void onBottomNavTap(int index) {
    setState(() {
      _currentNavPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
        ),
      ),
      body: _allNavPages[_currentNavPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavPage,
        backgroundColor: Color.fromRGBO(28, 28, 30, 1),
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onBottomNavTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home_outlined,
                color: kPrimaryColor,
                size: 30,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white38,
                size: 30,
              ),
              //  SvgPicture.asset(
              //   "assets/icons/Shop Icon.svg",
              //   color: kPrimaryColor,
              // ),
              // icon: SvgPicture.asset(
              //   "assets/icons/Shop Icon.svg",
              //   color: Colors.white,
              // ),
              label: ""),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.search_rounded,
                color: kPrimaryColor,
                size: 30,
              ),
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white38,
                size: 30,
              ),
              // activeIcon: SvgPicture.asset(
              //   "assets/icons/Heart Icon.svg",
              //   color: kPrimaryColor,
              // ),
              // icon: SvgPicture.asset(
              //   "assets/icons/Heart Icon.svg",
              //   color: Colors.white,
              // ),
              label: ""),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.chat_outlined,
                color: kPrimaryColor,
                size: 30,
              ),
              icon: Icon(
                Icons.chat_outlined,
                color: Colors.white38,
                size: 30,
              ),
              // activeIcon: SvgPicture.asset(
              //   "assets/icons/Chat bubble Icon.svg",
              //   color: kPrimaryColor,
              // ),
              // icon: SvgPicture.asset(
              //   "assets/icons/Chat bubble Icon.svg",
              //   color: Colors.white,
              // ),
              label: ""),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_outlined,
                color: kPrimaryColor,
                size: 30,
              ),
              icon: Icon(
                Icons.person_outlined,
                color: Colors.white38,
                size: 30,
              ),
              // activeIcon: SvgPicture.asset(
              //   "assets/icons/User Icon.svg",
              //   color: kPrimaryColor,
              // ),
              // icon: SvgPicture.asset(
              //   "assets/icons/User Icon.svg",
              //   color: Colors.white,
              // ),
              label: ""),
        ],
      ),
    );
  }
}
