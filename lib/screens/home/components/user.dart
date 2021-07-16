import 'dart:convert';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/models/Feedbacklink.dart';
import 'package:redcircleflutter/models/tellFriend.dart';
import 'package:redcircleflutter/screens/account/contactUs.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:redcircleflutter/screens/account/membershipTabs.dart';
import 'package:redcircleflutter/screens/account/changePassword.dart';
import 'package:redcircleflutter/screens/account/personalDetails.dart';
import 'package:redcircleflutter/screens/account/privacyPolicy.dart';
import 'package:redcircleflutter/screens/account/termsConditions.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;

class User extends StatelessWidget {
  Future<void> share() async {
    //{{url}}/get_tell_friend.php?token={{token}}
    String url = root + "/" + const_get_tell_friend + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        TellFriend tellFriend = TellFriend.fromJson(res);

        await FlutterShare.share(
            title: 'Share',
            text: tellFriend.tellFriend,
            linkUrl: '',
            chooserTitle: 'Example Chooser Title');
      }
    }
  }

  // Future<Feedbacklink> futureFeedbacklink;
  Future<Feedbacklink> fetchFeedbacklink() async {
    //{{url}}/get_feedbacklink.php?token={{token}}
    String url = root + "/" + const_get_feedbacklink + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        Feedbacklink feedbacklink = Feedbacklink.fromJson(res);
        return feedbacklink;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Container(
            color: KBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                Center(
                    child: Text(
                  "ACCOUNT",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w200),
                )),
                SizedBox(
                    height: getProportionateScreenWidth(
                        SizeConfig.screenHeight * 0.02)),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PROFILE",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalDetails(),
                                )),
                            child: Text(
                              "Personal details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          // Text(
                          //   "Notifications",
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.w200),
                          // ),
                          // SizedBox(
                          //     height: getProportionateScreenWidth(
                          //         SizeConfig.screenHeight * 0.01)),
                          // InkWell(
                          //   onTap: () {
                          //     final Event event = Event(
                          //       title: 'Event title',
                          //       description: 'Event description',
                          //       location: 'Event location',
                          //       startDate: DateTime(2021, 7, 7, 3, 0),
                          //       endDate: DateTime(2021, 7, 8, 3, 0),
                          //       iosParams: IOSParams(
                          //         reminder: Duration(
                          //             /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                          //       ),
                          //       androidParams: AndroidParams(
                          //         emailInvites: [], // on Android, you can add invite emails to your event.
                          //       ),
                          //     );
                          //     Add2Calendar.addEvent2Cal(event);
                          //   },
                          //   child: Text(
                          //     "Synchronise calendar",
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.w200),
                          //   ),
                          // ),
                          // SizedBox(
                          //     height: getProportionateScreenWidth(
                          //         SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembershipTabs(),
                                )),
                            child: Text(
                              "Membership plan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Divider(
                            thickness: 0.1,
                            color: Colors.white,
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.03),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "SECURITY",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePassword(),
                                )),
                            child: Text(
                              "Change password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          // SizedBox(
                          //     height: getProportionateScreenWidth(
                          //         SizeConfig.screenHeight * 0.01)),
                          // Text(
                          //   "Sign in with Face ID",
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.w200),
                          // ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Divider(
                            thickness: 0.1,
                            color: Colors.white,
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.03),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "LEGAL",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsCondictions(),
                                )),
                            child: Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Privacypolicy())),
                            child: Text(
                              "Privacy policy",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Divider(
                            thickness: 0.1,
                            color: Colors.white,
                            height: getProportionateScreenHeight(
                                SizeConfig.screenHeight * 0.03),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          Text(
                            "SUPPORT",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs())),
                            child: Text(
                              "Contact us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          FutureBuilder(
                            builder: (context, projectSnap) {
                              if (projectSnap.connectionState ==
                                      ConnectionState.none &&
                                  projectSnap.hasData == null) {
                                return Center(
                                    child: new CircularProgressIndicator());
                              } else if (projectSnap.hasData) {
                                Feedbacklink val = projectSnap.data;
                                return InkWell(
                                  // onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => GiveUsFeedback())),
                                  onTap: () => StoreRedirect.redirect(
                                      androidAppId:
                                          val.AndroidLink, // "com.whatsapp",
                                      iOSAppId: val.IosLink), // "310633997"
                                  child: Text(
                                    "Give us feedback",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200),
                                  ),
                                );
                              }
                              return Text(
                                "Give us feedback",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200),
                              );
                            },
                            future: fetchFeedbacklink(),
                          ),

                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () async => share(),
                            child: Text(
                              "Tell a friend",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //         child: Row(
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.only(right: 8.0),
                          //           child: FaIcon(
                          //             FontAwesomeIcons.facebook,
                          //             color: Color.fromRGBO(6, 97, 188, 1),
                          //             size: 27,
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(right: 8.0),
                          //           child: Container(
                          //             width: 27,
                          //             decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(40),
                          //                 gradient: LinearGradient(
                          //                   begin: Alignment.topCenter,
                          //                   end: Alignment.bottomCenter,
                          //                   colors: [
                          //                     Colors.pink,
                          //                     Colors.pink,
                          //                     Colors.yellow,
                          //                   ],
                          //                 )),
                          //             child: Center(
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(5.0),
                          //                 child: FaIcon(
                          //                   FontAwesomeIcons.instagram,
                          //                   color: Colors.white,
                          //                   size: 17,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(right: 8.0),
                          //           child: Container(
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(40),
                          //               color: Colors.blue[600],
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(5.0),
                          //               child: FaIcon(
                          //                 FontAwesomeIcons.linkedinIn,
                          //                 color: Colors.white,
                          //                 size: 17,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(40),
                          //             color: Colors.blue,
                          //           ),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(5.0),
                          //             child: FaIcon(
                          //               FontAwesomeIcons.twitter,
                          //               color: Colors.white,
                          //               size: 17,
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          //   ],
                          // ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          InkWell(
                            onTap: () => {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'LogOut',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  content: Text(
                                    'Do you want to log out?',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  elevation: 100,
                                  backgroundColor: KBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              kPrimaryColor.withOpacity(0.8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async => {
                                        if (await logOut())
                                          {
                                            Navigator.pushNamed(
                                                context, SignInScreen.routeName)
                                          }
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            },
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
