import 'package:flutter/material.dart';
import 'package:redcircleflutter/components/Exit.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/screens/calendar/calendar.dart';
import 'package:redcircleflutter/screens/home/components/main_card.dart';
import 'package:redcircleflutter/screens/offers/offers.dart';
import 'package:redcircleflutter/screens/request/request.dart';
import 'package:redcircleflutter/screens/wallet/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController controller = PageController(initialPage: 0);

  static SharedPreferences _pref;
  Future _getfName() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(kfnamePrefKey);
  }

  String fname = "";
  @override
  void initState() {
    _getfName().then((value) {
      setState(() {
        fname = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.page.toInt() == 0)
          return onWillPop(context);
        else {
          KeyboardUtil.hideKeyboard(context);
          controller.animateToPage(
            0,
            duration: Duration(milliseconds: 1),
            curve: Curves.linear,
          );
          return false;
        }
      },
      child: SafeArea(
        child: Container(
          color: KBackgroundColor,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controller,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Center(
                      child: Text(
                    "Good Morning",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
                  )),
                  Center(
                      child: Text(
                    fname,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w200),
                  )),
                  SizedBox(
                      height: getProportionateScreenWidth(
                          SizeConfig.screenHeight * 0.05)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.animateToPage(
                        1,
                        duration: Duration(milliseconds: 3),
                        curve: Curves.linear,
                      ),
                      // Navigator.pushNamed(context, CalendarScreen.routeName),
                      child: MainCard(
                        title: 'CALANDER',
                        subtitle: 'Today, Wed 30 Dec 2020',
                        leftDesc: '8:00 PM',
                        rightDesc: 'Four Seasons Hotel Moscow',
                        underline: true,
                        iconPath: "calendaricon.svg",
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height: getProportionateScreenWidth(
                  //         SizeConfig.screenHeight * 0.02)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.animateToPage(
                        2,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.linear,
                      ),
                      child: MainCard(
                        title: 'REQUESTS',
                        subtitle: 'Upcoming Events',
                        leftDesc: 'in 30 days',
                        rightDesc: 'Booking At Chalet Aura',
                        underline: true,
                        iconPath: "bell.svg",
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height: getProportionateScreenWidth(
                  //         SizeConfig.screenHeight * 0.02)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.animateToPage(
                        3,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.linear,
                      ),
                      child: MainCard(
                          title: 'OFFERS',
                          subtitle:
                              'Ski Chalets in Courchevel Normandy. Davos Zermalt and More...',
                          leftDesc: '',
                          rightDesc: '',
                          underline: true,
                          iconPath: "offers-icon.svg"),
                    ),
                  ),
                  // SizedBox(
                  //     height: getProportionateScreenWidth(
                  //         SizeConfig.screenHeight * 0.02)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.animateToPage(
                        4,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.linear,
                      ),
                      child: MainCard(
                        title: 'WALLETS &\nREWARDS',
                        subtitle: 'Top up your wallet & earn cashback rewards.',
                        leftDesc: '',
                        rightDesc: '',
                        underline: false,
                        iconPath: "walleticon.svg",
                      ),
                    ),
                  ),
                ],
              ),
              CalendarScreen(controller),
              Requests(controller),
              Offers(controller),
              Wallet(controller),
            ],
          ),
        ),
      ),
    );
  }
}

// class Body extends StatelessWidget {
//   static SharedPreferences _pref;
//   Future _getName() async {
//      _pref = await SharedPreferences.getInstance();
//     return _pref.getString(kEmailPrefKey);
//   }

//   final PageController controller = PageController(initialPage: 0);
//   @override
//   Widget build(BuildContext context) {
//     return StatefulWrapper(
//       onInit: () {
//         _getName().then((value) {
//           print('Async done');
//         });
//       },
//       child: WillPopScope(
//         onWillPop: () async {
//           if (controller.page.toInt() == 0)
//             return onWillPop(context);
//           else {
//             KeyboardUtil.hideKeyboard(context);
//             controller.animateToPage(
//               0,
//               duration: Duration(milliseconds: 1),
//               curve: Curves.linear,
//             );
//             return false;
//           }
//         },
//         child: SafeArea(
//           child: Container(
//             color: KBackgroundColor,
//             child: PageView(
//               physics: NeverScrollableScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               controller: controller,
//               children: <Widget>[
//                 Column(
//                   children: [
//                     SizedBox(height: getProportionateScreenHeight(30)),
//                     Center(
//                         child: Text(
//                       "Good Morning",
//                       style:
//                           TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
//                     )),
//                     Center(
//                         child: Text(
//                       "Alex",
//                       style: TextStyle(
//                           fontSize: 25,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w200),
//                     )),
//                     SizedBox(
//                         height: getProportionateScreenWidth(
//                             SizeConfig.screenHeight * 0.05)),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => controller.animateToPage(
//                           1,
//                           duration: Duration(milliseconds: 3),
//                           curve: Curves.linear,
//                         ),
//                         // Navigator.pushNamed(context, CalendarScreen.routeName),
//                         child: MainCard(
//                           title: 'CALANDER',
//                           subtitle: 'Today, Wed 30 Dec 2020',
//                           leftDesc: '8:00 PM',
//                           rightDesc: 'Four Seasons Hotel Moscow',
//                           underline: true,
//                           iconPath: "calendaricon.svg",
//                         ),
//                       ),
//                     ),
//                     // SizedBox(
//                     //     height: getProportionateScreenWidth(
//                     //         SizeConfig.screenHeight * 0.02)),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => controller.animateToPage(
//                           2,
//                           duration: Duration(milliseconds: 1),
//                           curve: Curves.linear,
//                         ),
//                         child: MainCard(
//                           title: 'REQUESTS',
//                           subtitle: 'Upcoming Events',
//                           leftDesc: 'in 30 days',
//                           rightDesc: 'Booking At Chalet Aura',
//                           underline: true,
//                           iconPath: "bell.svg",
//                         ),
//                       ),
//                     ),
//                     // SizedBox(
//                     //     height: getProportionateScreenWidth(
//                     //         SizeConfig.screenHeight * 0.02)),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => controller.animateToPage(
//                           3,
//                           duration: Duration(milliseconds: 1),
//                           curve: Curves.linear,
//                         ),
//                         child: MainCard(
//                             title: 'OFFERS',
//                             subtitle:
//                                 'Ski Chalets in Courchevel Normandy. Davos Zermalt and More...',
//                             leftDesc: '',
//                             rightDesc: '',
//                             underline: true,
//                             iconPath: "offers-icon.svg"),
//                       ),
//                     ),
//                     // SizedBox(
//                     //     height: getProportionateScreenWidth(
//                     //         SizeConfig.screenHeight * 0.02)),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => controller.animateToPage(
//                           4,
//                           duration: Duration(milliseconds: 1),
//                           curve: Curves.linear,
//                         ),
//                         child: MainCard(
//                           title: 'WALLETS &\nREWARDS',
//                           subtitle:
//                               'Top up your wallet & earn cashback rewards.',
//                           leftDesc: '',
//                           rightDesc: '',
//                           underline: false,
//                           iconPath: "walleticon.svg",
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 CalendarScreen(controller),
//                 Requests(controller),
//                 Offers(controller),
//                 Wallet(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// @override
// Widget build(BuildContext context) {
//   return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: getProportionateScreenHeight(30)),
//             Center(
//                 child: Text(
//               "Good Morning",
//               style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
//             )),
//             Center(
//                 child: Text(
//               "Alex",
//               style: TextStyle(
//                   fontSize: 25,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w200),
//             )),
//             SizedBox(
//                 height: getProportionateScreenWidth(
//                     SizeConfig.screenHeight * 0.05)),
//             InkWell(
//               onTap: () =>
//                   Navigator.pushNamed(context, CalendarScreen.routeName),
//               child: MainCard(
//                 title: 'CALANDER',
//                 subtitle: 'Today, Wed 30 Dec 2020',
//                 leftDesc: '8:00 PM',
//                 rightDesc: 'Four Seasons Hotel Moscow',
//                 underline: true,
//               ),
//             ),
//             SizedBox(
//                 height: getProportionateScreenWidth(
//                     SizeConfig.screenHeight * 0.02)),
//             MainCard(
//               title: 'REQUESTS',
//               subtitle: 'Upcoming Events',
//               leftDesc: 'in 30 days',
//               rightDesc: 'Booking At Chalet Aura',
//               underline: true,
//             ),
//             SizedBox(
//                 height: getProportionateScreenWidth(
//                     SizeConfig.screenHeight * 0.02)),
//             MainCard(
//               title: 'OFFERS',
//               subtitle:
//                   'Ski Chalets in Courchevel Normandy. Davos Zermalt and More...',
//               leftDesc: '',
//               rightDesc: '',
//               underline: true,
//             ),
//             SizedBox(
//                 height: getProportionateScreenWidth(
//                     SizeConfig.screenHeight * 0.02)),
//             MainCard(
//               title: 'WALLETS & \n REWARDS',
//               subtitle: 'Top up your wallet & earn cashback rewards.',
//               leftDesc: '',
//               rightDesc: '',
//               underline: false,
//             ),
//           ],
//         ),
//       ),

//   );
// }
// }
