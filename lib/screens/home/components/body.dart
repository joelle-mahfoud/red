import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/Exit.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/models/Booking.dart';
import 'package:redcircleflutter/models/Offer.dart';
import 'package:redcircleflutter/models/checkUser.dart';
import 'package:redcircleflutter/screens/calendar/calendar.dart';
import 'package:redcircleflutter/screens/home/components/main_card.dart';
import 'package:redcircleflutter/screens/offers/offers.dart';
import 'package:redcircleflutter/screens/request/request.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import 'package:redcircleflutter/screens/wallet/wallet.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//http://192.168.0.112:8383/redcircle/web/api/get_nearest_bookings.php?token=rb115oc-Rcas|Kredcircleu&client_id=19&status=3
Future<Booking> futureBooked;
Future<Booking> fetchBooked() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  String url = root +
      "/" +
      const_get_nearest_bookings +
      "?token=" +
      token +
      "&client_id=" +
      clientId +
      "&status=3"; //3 Booked
  print(url);
  dynamic responce =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  print(" ${responce.body}");

  if (responce.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(responce.body);
    if (res['result'] == 1) {
      print(res);
      Booking booking = Booking.fromJson(res);
      return booking;
    } else {
      print(" ${res['message']}");
      return null;
    }
  }
  throw Exception('Failed to load');
}

//http://192.168.0.112:8383/redcircle/web/api/get_nearest_bookings.php?token=rb115oc-Rcas|Kredcircleu&client_id=19&status=1
Future<Booking> futureRequested;
Future<Booking> fetchRequested() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  String url = root +
      "/" +
      const_get_nearest_bookings +
      "?token=" +
      token +
      "&client_id=" +
      clientId +
      "&status=2"; //-1
  print(url);
  dynamic responce =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  print(" ${responce.body}");

  if (responce.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(responce.body);
    if (res['result'] == 1) {
      print(res);
      Booking booking = Booking.fromJson(res);
      return booking;
    } else {
      print(" ${res['message']}");
      return null;
    }
  }
  throw Exception('Failed to load');
}

//{{url}}/get_random_offer.php?token={{token}}
Future<Offer> futureRandomOffer;
Future<Offer> fetchRandomOffer() async {
  String url =
      root + "/" + const_get_random_offer + "?token=" + token; //1 Request
  print(url);
  dynamic responce =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  print(" ${responce.body}");

  if (responce.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(responce.body);
    if (res['result'] == 1) {
      print(res);
      Offer offer = Offer.fromJson(res);
      return offer;
    } else {
      print(" ${res['message']}");
      return null;
    }
  }
  throw Exception('Failed to load');
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  final PageController controller = PageController(initialPage: 0);
  static SharedPreferences _pref;
  Future _getfName() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(kfnamePrefKey);
  }

  String fname = "";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    await CheckUserCanUsed(state, context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    CheckUserCanUsed(AppLifecycleState.resumed, context);
    WidgetsBinding.instance.addObserver(this);
    _getfName().then((value) {
      setState(() {
        fname = value;
      });
    });
    futureBooked = fetchBooked();
    futureRequested = fetchRequested();
    futureRandomOffer = fetchRandomOffer();
    super.initState();
  }

  String calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    int res = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (res == 0)
      return "Today ";
    else if (res == 1)
      return "Tomorrow ";
    else
      return "";
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Center(
                        child: Text(
                      "Weclome",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
                    )),
                    Center(
                        child: Text(
                      fname,
                      //fname[0].toUpperCase() + fname.substring(1),
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
                        child: FutureBuilder(
                          builder: (context, projectSnap) {
                            if (projectSnap.connectionState ==
                                    ConnectionState.none &&
                                projectSnap.hasData == null) {
                              return Center(child: CircularProgressIndicator());
                            } else if (projectSnap.hasData) {
                              Booking booking = projectSnap.data;
                              final DateFormat formatter =
                                  DateFormat('E dd MMM yyyy');
                              return MainCard(
                                title: 'CALANDER',
                                subtitle: calculateDifference(
                                        booking.startDate) +
                                    formatter.format(booking
                                        .startDate), //  'Today, Wed 30 Dec 2020',
                                leftDesc: DateFormat('kk:mm a')
                                    .format(booking.startDate),
                                rightDesc: booking
                                    .title, // 'Four Seasons Hotel Moscow',
                                underline: true,
                                iconPath: "calendaricon.svg",
                              );
                            }
                            return MainCard(
                              title: 'CALANDER',
                              subtitle: "Upcoming Bookings \nNothing",
                              leftDesc: "",
                              rightDesc: "", // 'Four Seasons Hotel Moscow',
                              underline: true,
                              iconPath: "calendaricon.svg",
                            );
                          },
                          future: futureBooked,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => controller.animateToPage(
                          2,
                          duration: Duration(milliseconds: 1),
                          curve: Curves.linear,
                        ),
                        child: FutureBuilder(
                          builder: (context, projectSnap) {
                            if (projectSnap.connectionState ==
                                    ConnectionState.none &&
                                projectSnap.hasData == null) {
                              return Center(child: CircularProgressIndicator());
                            } else if (projectSnap.hasData) {
                              Booking booking = projectSnap.data;
                              int days = booking.startDate
                                  .difference(DateTime.now())
                                  .inDays;
                              String leftDesc = (days == 0)
                                  ? ""
                                  : "in " + days.toString() + " days";
                              String subtitle = (booking.status == "Request")
                                  ? "Upcoming Requests"
                                  : ((booking.status == "Approve")
                                      ? "Request To Pay"
                                      : "Upcoming Booking");
                              return MainCard(
                                title: 'REQUESTS',
                                subtitle: subtitle,
                                leftDesc: leftDesc,
                                rightDesc: booking.title,
                                underline: true,
                                iconPath: "bell.svg",
                              );
                            }
                            return MainCard(
                              title: 'REQUESTS',
                              subtitle: 'Upcoming Events \nNothing',
                              leftDesc: "",
                              rightDesc: "",
                              underline: true,
                              iconPath: "bell.svg",
                            );
                          },
                          future: futureRequested,
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
                        child: FutureBuilder(
                          builder: (context, projectSnap) {
                            if (projectSnap.connectionState ==
                                    ConnectionState.none &&
                                projectSnap.hasData == null) {
                              return Center(child: CircularProgressIndicator());
                            } else if (projectSnap.hasData) {
                              Offer offer = projectSnap.data;
                              return MainCard(
                                title: 'OFFERS',
                                subtitle: offer.descriptionEn,
                                leftDesc: '',
                                rightDesc: '',
                                underline: true,
                                iconPath: "offers-icon.svg",
                              );
                            }
                            return MainCard(
                              title: 'OFFERS',
                              subtitle: "",
                              leftDesc: "",
                              rightDesc: "",
                              underline: true,
                              iconPath: "offers-icon.svg",
                            );
                          },
                          future: futureRandomOffer,
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
                          4,
                          duration: Duration(milliseconds: 1),
                          curve: Curves.linear,
                        ),
                        child: MainCard(
                          title: 'WALLETS &\nREWARDS',
                          subtitle:
                              'Top up your wallet & earn cashback rewards.',
                          leftDesc: '',
                          rightDesc: '',
                          underline: false,
                          iconPath: "walleticon.svg",
                        ),
                      ),
                    ),
                  ],
                ),
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
