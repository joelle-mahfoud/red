import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:redcicrle/screens/home/home_screen.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
// import 'package:redcircleflutter/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  MenuState selectedMenu = MenuState.home;
  void setMenuState({MenuState selectedMenu}) {
    setState(() {
      this.selectedMenu = selectedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.white;
    // Color(0xFFB6B6B6);
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Color.fromRGBO(28, 28, 30, 1),
        boxShadow: [
          // BoxShadow(
          //   offset: Offset(0, -15),
          //   blurRadius: 20,
          //   color: Color(0xFFDADADA).withOpacity(0.15),
          // ),
        ],
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(40),
        //   topRight: Radius.circular(40),
        // ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        if (selectedMenu != MenuState.home)
                          {
                            Navigator.pushNamed(context, HomeScreen.routeName),
                            setMenuState(selectedMenu: MenuState.home),
                          }
                      }),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Heart Icon.svg",
                    color: MenuState.search == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        // if (selectedMenu != MenuState.search)
                        //   Navigator.pushNamed(context, HomeScreen.routeName),
                        setMenuState(selectedMenu: MenuState.search),
                      }),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Chat bubble Icon.svg",
                    color: MenuState.message == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        // if (selectedMenu != MenuState.message)
                        //   Navigator.pushNamed(context, HomeScreen.routeName),
                        setMenuState(selectedMenu: MenuState.message),
                      }),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        // if (selectedMenu != MenuState.profile)
                        //   Navigator.pushNamed(context, HomeScreen.routeName),
                        setMenuState(selectedMenu: MenuState.profile),
                      }
                  // onPressed: () => Navigator.pushNamed(context, ProfileScreen.routeName),
                  ),
            ],
          )),
    );
  }
}
