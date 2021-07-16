import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/userInfo.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PersonalDetails extends StatefulWidget {
  // static String routeName = "/PersonalDetails";
  const PersonalDetails({Key key}) : super(key: key);

  @override
  PersonalDetailsState createState() => PersonalDetailsState();
}

class PersonalDetailsState extends State<PersonalDetails> {
  @override
  void initState() {
    super.initState();
    futureUserInfo = fetchUserInfo();
  }

  Future<UserInfo> futureUserInfo;
  Future<UserInfo> fetchUserInfo() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    String url = root +
        "/" +
        get_user_info +
        "?token=" +
        token +
        "&id=" +
        clientId.toString();
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      // if (res['result'] == 1) {
      print(res);
      return UserInfo.fromJson(res);
      // } else {
      //   print(" ${res['message']}");
      //   return null;
      // }
    }
    throw Exception('Failed to load');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          "Personal details",
          style: TextStyle(
              color: kPrimaryColor, fontSize: getProportionateScreenHeight(23)),
        ),
        toolbarHeight: getProportionateScreenHeight(90),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return Center(child: new CircularProgressIndicator());
          } else if (projectSnap.hasData) {
            UserInfo userinfo = projectSnap.data;
            return Center(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Text(
                      userinfo.fname + " " + userinfo.lname,
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      userinfo.email,
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      userinfo.dob,
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      userinfo.country,
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Text(
                      ((userinfo.position != null && userinfo.position != "")
                              ? userinfo.position
                              : "") +
                          ((userinfo.companyName != null &&
                                  userinfo.companyName != "")
                              ? "\n at " + userinfo.companyName
                              : ""),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: getProportionateScreenWidth(20),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    // Text(
                    //   "Intersets:\n"
                    //   "Arts & Culture\nWellness & Beauty.",
                    //   textAlign: TextAlign.center,
                    //   // maxLines: 3,
                    //   // softWrap: true,
                    //   // overflow: TextOverflow.fade,
                    //   style: TextStyle(
                    //     color: Colors.white54,
                    //     fontSize: getProportionateScreenWidth(18),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }
          return Center(child: new CircularProgressIndicator());
        },
        future: futureUserInfo,
      ),
    );
  }
}
