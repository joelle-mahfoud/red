import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/offersList.dart';
import 'package:redcircleflutter/components/offersListShowAll.dart';
import 'package:redcircleflutter/models/Services.dart';
import 'package:http/http.dart' as http;
import 'package:redcircleflutter/size_config.dart';

Future<List<SubService>> fetchSubServices(int serviceId) async {
  String url = root +
      "/" +
      const_get_sub_services +
      "?token=" +
      token +
      "&id=" +
      serviceId.toString();
  print(url);
  dynamic responce =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  print(" ${responce.body}");

  if (responce.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(responce.body);
    if (res['result'] == 1) {
      print(res);
      List<SubService> services =
          (res['data'] as List).map((i) => SubService.fromJson(i)).toList();
      return services;
    } else {
      print(" ${res['message']}");
      return null;
    }
  }
  throw Exception('Failed to load');
}

class Body extends StatefulWidget {
  final int serviceId;
  final int subServiceCount;
  const Body({Key key, this.serviceId, this.subServiceCount});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<SubService>> subServices;
  @override
  void initState() {
    super.initState();
    if (widget.subServiceCount != 0)
      subServices = fetchSubServices(widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.subServiceCount == 0
                ? OffersListShowAll(
                    serviceId: widget.serviceId,
                  )
                : FutureBuilder(
                    builder: (context, projectSnap) {
                      if (projectSnap.connectionState == ConnectionState.none &&
                          projectSnap.hasData == null) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (projectSnap.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: projectSnap.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(
                                      SizeConfig.screenWidth * 0.04),
                                ),
                                child: OffersList(
                                  title: projectSnap.data[index].title,
                                  seeMorePress: () {},
                                  // onSelectCard: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => BookingDescription(),
                                  //     )),
                                  subserviceId:
                                      int.parse(projectSnap.data[index].id),
                                ),
                              );
                            },
                          );
                        } else
                          return Container();
                      }
                    },
                    future: subServices,
                  ),

            // Padding(
            //   padding: EdgeInsets.only(
            //     left:
            //         getProportionateScreenWidth(SizeConfig.screenWidth * 0.05),
            //   ),
            //   child: OffersList(
            //       title: "CHALET COLLECTION",
            //       seeMorePress: () {},
            //       api: 'jsonplaceholder.typicode.com'),
            // ),
            // SizedBox(
            //   height: getProportionateScreenHeight(5),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     left:
            //         getProportionateScreenWidth(SizeConfig.screenWidth * 0.05),
            //   ),
            //   child: OffersList(
            //       title: "VILLA COLLECTION",
            //       seeMorePress: () {},
            //       api: 'jsonplaceholder.typicode.com'),
            // ),
            // SizedBox(
            //   height: getProportionateScreenHeight(5),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     left:
            //         getProportionateScreenWidth(SizeConfig.screenWidth * 0.05),
            //   ),
            //   child: OffersList(
            //       title: "SUGGESTED FOR YOU",
            //       seeMorePress: () {},
            //       api: 'jsonplaceholder.typicode.com'),
            // ),
          ],
        ),
      ),
    );
  }
}
