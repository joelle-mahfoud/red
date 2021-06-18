import 'dart:convert';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> registration(
    String fname,
    String lname,
    String dob,
    String email,
    String password,
    String country,
    String companyName,
    String position) async {
  //"http://192.168.0.112:8383/redcircle/web/api/createuser.php?token=rb115oc-Rcas|Kredcircleu&fname=jalal&lname=jalal&dob=2020-12-16&email=jalal@hotmail.com&password=123&country_id=1&company_name=daily&position=poor"),
  dynamic response;
  print(root +
      "/" +
      const_registration +
      "?token=" +
      token +
      "&fname=" +
      fname +
      "&lname=" +
      lname +
      "&dob=" +
      dob +
      " &email=" +
      email +
      "&password=" +
      password +
      "&country_id=" +
      country.toString() +
      "&company_name=" +
      companyName +
      "&position=" +
      position);

  try {
    response = await http.post(
      Uri.parse(root +
          "/" +
          const_registration +
          "?token=" +
          token +
          "&fname=" +
          fname +
          "&lname=" +
          lname +
          "&dob=" +
          dob +
          " &email=" +
          email +
          "&password=" +
          password +
          "&country_id=" +
          country.toString() +
          "&company_name=" +
          companyName +
          "&position=" +
          position),
      headers: {"Accept": "application/json"},
    );
  } catch (e) {
    print(e);
  }

  print(" ${response.body}");
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(kfnamePrefKey, fname);
      _pref.setString(kEmailPrefKey, email);
      _pref.setString(kPassPrefKey, password);
      _pref.setString(kclientIdPrefKey, res['user_id'].toString());
      return true;
    } else {
      print(" ${res['message']}");
      return false;
    }
  } else
    return false;
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

  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res['result'] == 1) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(kfnamePrefKey, res['fname']);
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
