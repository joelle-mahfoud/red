import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:http/http.dart' as http;
import 'package:redcircleflutter/models/RemainingWallet.dart';
import 'package:redcircleflutter/models/checkUser.dart';
import 'package:redcircleflutter/models/clientReward.dart';
import 'package:redcircleflutter/screens/account/membershipTabs.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';
import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> updateBookingStatus(String bookingId) async {
  //http://192.168.0.112:8383/redcircle/web/api/update_booking.php?token=rb115oc-Rcas|Kredcircleu&id=14&status=3
  dynamic response;
  print(root +
      "/" +
      const_update_booking +
      "?token=" +
      token +
      "&id=" +
      bookingId +
      "&status=3");
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_update_booking +
          "?token=" +
          token +
          "&id=" +
          bookingId +
          "&status=3"),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      return true;
    } else {
      print(" ${res['message']}");
      return false;
    }
  } else
    return false;
}

Future<bool> onupdateStatus(String bookingID) async {
  if (await updateBookingStatus(bookingID)) {
    return true;
  }
  return false;
}

Future<bool> onAddUsedRewards(String bookingID, String totalprice) async {
  if (await addUsedRewards(bookingID, totalprice)) {
    await updateBookingStatus(bookingID);
    return true;
  }
  return false;
}

Future<ClientReward> onAddClientRewards(
    String bookingID, String totalprice) async {
  ClientReward clientRewards = await AddClientRewards(bookingID, totalprice);
  if (clientRewards.result == 1) {
    await updateBookingStatus(bookingID);
    return clientRewards;
  }
  return null;
}

Future<ClientReward> AddClientRewards(
    String bookingId, String totalPrice) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  //{{url}}/add_client_rewards.php?token={{token}}&client_id=37&total_price=1000&booking_id=44
  dynamic response;
  print(root +
      "/" +
      const_add_client_rewards +
      "?token=" +
      token +
      "&client_id=" +
      clientId +
      "&total_price=" +
      totalPrice +
      "&booking_id=" +
      bookingId);
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_add_client_rewards +
          "?token=" +
          token +
          "&client_id=" +
          clientId +
          "&total_price=" +
          totalPrice +
          "&booking_id=" +
          bookingId),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    ClientReward clientReward = ClientReward.fromJson(res);
    return clientReward;
  } else
    return null;
}

Future<bool> addUsedRewards(String bookingId, String totalPrice) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  dynamic response;
  print(root +
      "/" +
      const_add_used_rewards +
      "?token=" +
      token +
      "&client_id=" +
      clientId +
      "&amout=" +
      totalPrice +
      "&booking_id=" +
      bookingId);
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_add_used_rewards +
          "?token=" +
          token +
          "&client_id=" +
          clientId +
          "&amout=" +
          totalPrice +
          "&booking_id=" +
          bookingId),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      return true;
    } else {
      print(" ${res['message']}");
      return false;
    }
  } else
    return false;
}

Future<bool> addClientPackage(String packageId) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  dynamic response;
  print(root +
      "/" +
      const_add_client_package +
      "?token=" +
      token +
      "&client_id=" +
      clientId +
      "&pakage_id=" +
      packageId);
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_add_client_package +
          "?token=" +
          token +
          "&client_id=" +
          clientId +
          "&pakage_id=" +
          packageId),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      return true;
    } else {
      return false;
    }
  } else
    return false;
}

Future<RemainingWallet> addWallet(
    int walletType, String bookingId, String amount) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  dynamic response;
  print(root +
      "/" +
      const_add_client_wallet +
      "?token=" +
      token +
      "&client_id=" +
      clientId +
      "&wallet_type=" +
      walletType.toString() +
      "&booking_id=" +
      bookingId +
      "&amount=" +
      amount);
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_add_client_wallet +
          "?token=" +
          token +
          "&client_id=" +
          clientId +
          "&wallet_type=" +
          walletType.toString() +
          "&booking_id=" +
          bookingId +
          "&amount=" +
          amount),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    RemainingWallet remainingWallet = RemainingWallet.fromJson(res);
    return remainingWallet;
  } else
    return null;
}

Future<String> changePass(String oldPass, String newPass) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  //{{url}}/change_password.php?token={{token}}&user_id=38&old_password=123456&password=123
  dynamic response;
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_change_password +
          "?token=" +
          token +
          "&user_id=" +
          clientId +
          "&old_password=" +
          oldPass +
          "&password=" +
          newPass),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(root +
      "/" +
      const_change_password +
      "?token=" +
      token +
      "&user_id=" +
      clientId +
      "&old_password=" +
      oldPass +
      "&password=" +
      newPass);
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      _pref.setString(kPassPrefKey, newPass);
      return "";
    } else {
      print(" ${res['message']}");
      return res['message'];
    }
  } else
    return "Failed ,Please Check your internet.";
}

Future<List> login(String username, String pass) async {
  //"http://192.168.0.112:8383/redcircle/web/api/login.php?token=rb115oc-Rcas|Kredcircleu&password=123&email=JALAL@hotmail.com
  dynamic response;
  try {
    print(root);
    print(const_login);
    print(token);
    print(pass);
    print(username);

    response = await http.post(
      Uri.parse(root +
          "/" +
          const_login +
          "?token=" +
          token +
          "&password=" +
          pass +
          "&email=" +
          username),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(root +
      "/" +
      const_login +
      "?token=" +
      token +
      "&password=" +
      pass +
      "&email=" +
      username);

  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(
        kfnamePrefKey,
        res['fname'][0].toUpperCase() +
            (res['fname'].toString().length > 1
                ? res['fname'].substring(1)
                : ""),
      );
      _pref.setString(kEmailPrefKey, username);
      _pref.setString(kPassPrefKey, pass);
      _pref.setString(kclientIdPrefKey, res['id']);
      return [true, res['message']];
    } else {
      print(" ${res['message']}");
      return [false, res['message']];
    }
  } else
    return [false, 'ERROR'];
}

Future<bool> logOut() async {
  try {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(kfnamePrefKey, "");
    _pref.setString(kEmailPrefKey, "");
    _pref.setString(kPassPrefKey, "");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<CheckUser> checkClientStatusAndExpiredPackage() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String clientId = _pref.getString(kclientIdPrefKey);
  dynamic response;
  print(root +
      "/" +
      const_is_member +
      "?token=" +
      token +
      "&user_id=" +
      clientId);
  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_is_member +
          "?token=" +
          token +
          "&user_id=" +
          clientId),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }
  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    CheckUser checkUser = CheckUser.fromJson(res);
    return checkUser;
  } else
    return null;
}

Future<CheckUser> onCheckClientStatusAndExpiredPackage() async {
  return await checkClientStatusAndExpiredPackage();
}

Future<bool> CheckUserCanUsed(
    AppLifecycleState state, BuildContext context) async {
  if (state == AppLifecycleState.resumed) {
    CheckUser checkUser = await onCheckClientStatusAndExpiredPackage();
    if (checkUser.result == 0) {
      bool dialogresult = await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
                title: Text(
                  'Warning!',
                  style: TextStyle(color: kPrimaryColor),
                ),
                content: Text(
                  checkUser.message,
                  style: TextStyle(color: kPrimaryColor),
                ),
                elevation: 100,
                backgroundColor: KBackgroundColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: kPrimaryColor.withOpacity(0.8)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      'OK',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ],
              ));
      if (checkUser.userInactive == 1) {
        if (await logOut()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ));
        }
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MembershipTabs(),
            ));
      }
      return false;
    } else
      return true;
  } else
    return true;
}
