import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/chat/screens/ChatScreen.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/models/Offer.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;

class OfferDescription extends StatefulWidget {
  final String productId;
  const OfferDescription({@required this.productId});
  @override
  _OfferDescriptionState createState() => _OfferDescriptionState();
}

class _OfferDescriptionState extends State<OfferDescription> {
  Future<OfferDetail> offerDetails;
  Future<OfferDetail> fetchofferDetails() async {
    String url = root +
        "/" +
        const_get_listing_images +
        "?token=" +
        token +
        "&id=" +
        widget.productId.toString();
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print("body ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        return OfferDetail.fromJson(res);
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    return null;
  }

  List<Widget> _generateChildrens(List<OfferImages> myObjects) {
    var list = myObjects.map<List<Widget>>(
      (data) {
        var widgetList = <Widget>[];
        widgetList.add(Container(
          child: Image.network(
            root_pic + data.imgData,
            fit: BoxFit.cover,
          ),
          width: getProportionateScreenWidth(SizeConfig.screenHeight * 1),
        ));
        return widgetList;
      },
    ).toList();
    var flat = list.expand((i) => i).toList();
    return flat;
  }

  @override
  void initState() {
    super.initState();
    offerDetails = fetchofferDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
        ),
      ),
      body: FutureBuilder(
          future: offerDetails,
          builder: (context, projectSnap1) {
            if (projectSnap1.connectionState == ConnectionState.none &&
                projectSnap1.hasData == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (projectSnap1.hasData) {
                return Hero(
                  tag: projectSnap1.data.id.toString(),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: getProportionateScreenHeight(200),
                          width: double.infinity,
                          child: Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                Carousel(
                                  images: _generateChildrens(
                                      projectSnap1.data.data),
                                  dotSize: 5.0,
                                  dotSpacing: 15.0,
                                  dotColor: KBackgroundColor,
                                  dotIncreasedColor: kPrimaryColor,
                                  indicatorBgPadding: 5.0,
                                  dotBgColor: Colors.transparent,
                                  borderRadius: false,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.9),
                                            Colors.black.withOpacity(0.6),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.6),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Icon(
                                    Icons.keyboard_arrow_left_rounded,
                                    color: kPrimaryColor,
                                    size: getProportionateScreenWidth(40),
                                  ),
                                ),
                              ])),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(20)),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  projectSnap1.data.name,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Text(
                                  "Expirs on '" +
                                      projectSnap1.data.offerExpiryDate +
                                      "'",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          getProportionateScreenHeight(14),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Html(
                                    data: projectSnap1.data.descriptionEn,
                                    defaultTextStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize:
                                            getProportionateScreenWidth(14),
                                        fontWeight: FontWeight.bold)),
                                // Text(
                                //   projectSnap1.data.descriptionEn,
                                //   style: TextStyle(
                                //       color: Colors.white.withOpacity(0.6),
                                //       fontSize:
                                //           getProportionateScreenHeight(14),
                                //       fontWeight: FontWeight.bold),
                                // ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (await CheckUserCanUsed(
                              AppLifecycleState.resumed, context)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                          productId: projectSnap1.data.id,
                                          productName: projectSnap1.data.name,
                                        )));
                            // PAChat(
                            //     productid: projectSnap1.data.id,
                            //     productName:
                            //         projectSnap1.data.name)));
                          }
                        },
                        child: Center(
                          child: Container(
                            // height: getProportionateScreenHeight(50),
                            width: getProportionateScreenWidth(
                                SizeConfig.screenWidth * 0.85),
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(
                                    SizeConfig.screenHeight * 0.02)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: KBorderColor,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "SEND TO PA ",
                                    style: TextStyle(
                                        color: Color.fromRGBO(22, 22, 23, 0.8),
                                        fontFamily: "Raleway",
                                        fontSize:
                                            getProportionateScreenWidth(15),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.subdirectory_arrow_right_sharp,
                                      size: 18,
                                      color: Color.fromRGBO(22, 22, 23, 0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                    ],
                  )),
                );
              } else
                return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
