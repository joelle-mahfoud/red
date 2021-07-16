import 'dart:async';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/about.dart';
import 'package:redcircleflutter/size_config.dart';

class Privacypolicy extends StatefulWidget {
  const Privacypolicy({Key key}) : super(key: key);

  @override
  _PrivacypolicyState createState() => _PrivacypolicyState();
}

class _PrivacypolicyState extends State<Privacypolicy> {
  @override
  void initState() {
    super.initState();
    futurePrivacyPolicy = fetchPrivacyPolicy();
  }

  Future<TitleEn> futurePrivacyPolicy;
  Future<TitleEn> fetchPrivacyPolicy() async {
    String url = root + "/" + const_get_privacy_policy + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        TitleEn titleEn = TitleEn.fromJson(res);
        return titleEn;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KBackgroundColor,
        brightness: Brightness.dark,
        title: Text(
          "Privacy Policy",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: KBackgroundColor,
          ),
          child: FutureBuilder(
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none &&
                  projectSnap.hasData == null) {
                return Center(child: new CircularProgressIndicator());
              } else if (projectSnap.hasData) {
                TitleEn val = projectSnap.data;
                return SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(25)),
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.07),
                            Html(
                                data: val.titleEn,
                                defaultTextStyle: TextStyle(
                                    color: Color.fromRGBO(251, 255, 255, 1),
                                    fontSize: getProportionateScreenWidth(15))),
                            SizedBox(height: SizeConfig.screenHeight * 0.08),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center();
            },
            future: futurePrivacyPolicy,
          ),
        ),
      ),
    );
  }
}
