import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Offer.dart';
import 'package:redcircleflutter/screens/offers/components/offersList.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;
import 'offer_description.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<Offer>> offer;
  Future<List<Offer>> fetchOffers() async {
    String url = root + "/" + const_get_offer_listing + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<Offer> services =
            (res['data'] as List).map((i) => Offer.fromJson(i)).toList();
        return services;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  @override
  void initState() {
    super.initState();
    offer = fetchOffers();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (projectSnap.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.05),
                        right: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.05),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            showSecondPage(context, projectSnap.data[1].id),
                        child: Column(
                          children: [
                            Image.network(
                                root_pic + projectSnap.data[1].mainImg),
                            Container(
                              color: Colors.black,
                              height: getProportionateScreenHeight(
                                  SizeConfig.screenHeight * 0.15),
                              width: getProportionateScreenWidth(
                                  SizeConfig.screenWidth * 0.9),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      projectSnap.data[1].name,
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize:
                                              getProportionateScreenWidth(19)),
                                    ),
                                    SizedBox(
                                        height: SizeConfig.screenHeight * 0.01),
                                    Text(
                                      "Expirs on '" +
                                          projectSnap.data[1].offerExpiryDate +
                                          "'",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenWidth(15)),
                                    ),
                                    SizedBox(
                                        height: SizeConfig.screenHeight * 0.01),
                                    Text(
                                      removeAllHtmlTags(
                                          projectSnap.data[1].descriptionEn),
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenWidth(14)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.05),
                      ),
                      child: OffersList(
                        offers: projectSnap.data,
                        title: "DISCOVER MORE",
                        seeMorePress: () {},
                      ),
                    ),
                  ],
                ),
              );
              // return GridView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: projectSnap.data.length,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 1),
              //     // physics: NeverScrollableScrollPhysics(),
              //     // primary: false,
              //     // shrinkWrap: true,
              //     itemBuilder: (BuildContext ctx, index) {
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.only(
              //               left: getProportionateScreenWidth(
              //                   SizeConfig.screenWidth * 0.05),
              //               right: getProportionateScreenWidth(
              //                   SizeConfig.screenWidth * 0.05),
              //             ),
              //             child: GestureDetector(
              //               onTap: () => showSecondPage(context),
              //               child: Column(
              //                 children: [
              //                   Image.network(
              //                       root_pic + projectSnap.data[index].mainImg),
              //                   // Image(
              //                   //   height: getProportionateScreenHeight(
              //                   //       SizeConfig.screenHeight * 0.22),
              //                   //   width: getProportionateScreenWidth(
              //                   //       SizeConfig.screenWidth * 0.9),
              //                   //   image: ,
              //                   //   fit: BoxFit.cover,
              //                   // ),
              //                   Container(
              //                     color: Colors.black,
              //                     height: getProportionateScreenHeight(
              //                         SizeConfig.screenHeight * 0.19),
              //                     width: getProportionateScreenWidth(
              //                         SizeConfig.screenWidth * 0.9),
              //                     child: Padding(
              //                       padding: EdgeInsets.all(
              //                           getProportionateScreenWidth(8)),
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.center,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             projectSnap.data[index].name,
              //                             style: TextStyle(
              //                                 color: kPrimaryColor,
              //                                 fontSize:
              //                                     getProportionateScreenWidth(
              //                                         19)),
              //                           ),
              //                           SizedBox(
              //                               height:
              //                                   SizeConfig.screenHeight * 0.01),
              //                           Text(
              //                             "Limited time",
              //                             style: TextStyle(
              //                                 color: Colors.white,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize:
              //                                     getProportionateScreenWidth(
              //                                         16)),
              //                           ),
              //                           SizedBox(
              //                               height:
              //                                   SizeConfig.screenHeight * 0.01),
              //                           Text(
              //                             projectSnap.data[index].descriptionEn,
              //                             maxLines: 2,
              //                             softWrap: true,
              //                             overflow: TextOverflow.ellipsis,
              //                             style: TextStyle(
              //                                 color: Colors.white,
              //                                 fontSize:
              //                                     getProportionateScreenWidth(
              //                                         16)),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             height: getProportionateScreenHeight(15),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(
              //               left: getProportionateScreenWidth(
              //                   SizeConfig.screenWidth * 0.05),
              //             ),
              //             child: OffersList(
              //               offers: projectSnap.data,
              //               title: "DISCOVER MORE",
              //               seeMorePress: () {},
              //             ),
              //           ),
              //         ],
              //       );
              //     });
            } else
              return Container();
          }
        },
        future: offer,
      ),
    );
  }

  void showSecondPage(BuildContext context, String productId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfferDescription(
            productId: productId,
          ),
        ));
  }
}
