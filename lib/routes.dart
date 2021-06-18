import 'package:flutter/widgets.dart';
import 'package:redcircleflutter/screens/home/components/Chat.dart';
import 'package:redcircleflutter/screens/about/about.dart';
// import 'package:redcircleflutter/screens/calendar/calendar.dart';
// import 'package:redcircleflutter/screens/home/home_screen_test.dart';
import 'package:redcircleflutter/screens/membership_plan/MemberShipPlan.dart';
import 'package:redcircleflutter/screens/registration/SubmitApplication/SubmitApplication.dart';
import 'package:redcircleflutter/screens/registration/assistance/assistance.dart';
import 'package:redcircleflutter/screens/registration/confirmBillingCycle/confirm_billing_cycle.dart';
import 'package:redcircleflutter/screens/registration/membershipApplication_About/membership_application_about.dart';
import 'package:redcircleflutter/screens/registration/membershipApplication_Occupation/membership_application_occupation.dart';

import 'package:redcircleflutter/screens/splash/splash_screen.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  About.routeName: (context) => About(),
  MembershipPlan.routeName: (context) => MembershipPlan(),
  ConfirmBillingCycle.routeName: (context) => ConfirmBillingCycle(),
  MembershipApplicationAbout.routeName: (context) =>
      MembershipApplicationAbout(),
  MembershipApplicationOccupation.routeName: (context) =>
      MembershipApplicationOccupation(),
  SubmitApplication.routeName: (context) => SubmitApplication(),
  Assistance.routeName: (context) => Assistance(),
  FlutterChat.routeName: (context) => FlutterChat(),
  // CalendarScreen.routeName: (context) => CalendarScreen(null),
  // Home_screen_test.routeName: (context) => Home_screen_test(),
};
