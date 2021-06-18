import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Services.dart';
import 'package:redcircleflutter/screens/BookingServices/bookingServices.dart';

import 'package:http/http.dart' as http;
import 'package:redcircleflutter/size_config.dart';

Future<List<Service>> fetchServices() async {
  String url = root + "/" + const_get_services + "?token=" + token;
  print(url);
  dynamic responce =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  print(" ${responce.body}");

  // final response =
  //     await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  if (responce.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(responce.body);
    if (res['result'] == 1) {
      print(res);
      List<Service> services =
          (res['data'] as List).map((i) => Service.fromJson(i)).toList();
      return services;
    } else {
      print(" ${res['message']}");
      throw Exception('Failed to load');
    }
  }
  throw Exception('Failed to load');
}

Future<List<Service>> main(bool isMain) async {
  List<Service> _futureOfList = await fetchServices();
  return _futureOfList.where((element) => element.isMain == isMain).toList();
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<Service>> mainServices;
  Future<List<Service>> moreServices;
  @override
  void initState() {
    super.initState();
    mainServices = main(true);
    moreServices = main(false);
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
                SizedBox(
                    height: getProportionateScreenHeight(
                        SizeConfig.screenHeight * 0.04)),
                Center(
                    child: Container(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.05),
                  child: Text(
                    "BOOKING SERVICES",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w200),
                  ),
                )),
                SizedBox(
                    height: getProportionateScreenHeight(
                        SizeConfig.screenHeight * 0.04)),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    // primary: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          FutureBuilder(
                            builder: (context, projectSnap) {
                              if (projectSnap.connectionState ==
                                      ConnectionState.none &&
                                  projectSnap.hasData == null) {
                                return Container();
                              } else if (projectSnap.hasData) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: projectSnap.data.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Material(
                                          color: Colors.black,
                                          child: InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Services(
                                                          title: projectSnap
                                                              .data[index]
                                                              .title,
                                                          serviceId: int.parse(
                                                            projectSnap
                                                                .data[index].id,
                                                          ),
                                                          subServiceCount:
                                                              projectSnap
                                                                  .data[index]
                                                                  .subservicecount),
                                                )),
                                            child: Container(
                                              height:
                                                  getProportionateScreenHeight(
                                                      100),
                                              width:
                                                  getProportionateScreenWidth(
                                                      SizeConfig.screenWidth *
                                                          1),
                                              // color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Image.network(
                                                        root_pic +
                                                            projectSnap
                                                                .data[index]
                                                                .image,
                                                        color: kPrimaryColor
                                                            .withOpacity(0.5),
                                                      ),
                                                      height:
                                                          getProportionateScreenWidth(
                                                              30),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              30),
                                                    ),
                                                    //   Icon(
                                                    // Icons.home_work_outlined,
                                                    // color: kPrimaryColor
                                                    //     .withOpacity(0.5),
                                                    // size:
                                                    //     getProportionateScreenWidth(
                                                    //         30),
                                                    // ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      projectSnap
                                                          .data[index].title,
                                                      style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                18),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_right_sharp,
                                                      color: kPrimaryColor,
                                                      size:
                                                          getProportionateScreenWidth(
                                                              20),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: getProportionateScreenWidth(
                                                SizeConfig.screenHeight *
                                                    0.01)),
                                      ],
                                    );
                                  },
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                            future: mainServices,
                          ),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.03)),
                          Center(
                              child: Text(
                            "More Services",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w200),
                          )),
                          SizedBox(
                              height: getProportionateScreenWidth(
                                  SizeConfig.screenHeight * 0.01)),
                          FutureBuilder(
                            builder: (context, projectSnap) {
                              if (projectSnap.connectionState ==
                                      ConnectionState.none &&
                                  projectSnap.hasData == null) {
                                return Container();
                              } else if (projectSnap.hasData) {
                                return GridView.builder(
                                    itemCount: projectSnap.data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          SizeConfig.screenWidth / 2,
                                      childAspectRatio: SizeConfig.screenWidth /
                                          (SizeConfig.screenHeight / 3),
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Services(
                                                    title: projectSnap
                                                        .data[index].title,
                                                    serviceId: int.parse(
                                                        projectSnap
                                                            .data[index].id),
                                                    subServiceCount: projectSnap
                                                        .data[index]
                                                        .subservicecount),
                                              )),
                                          child: Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    100),
                                            width: getProportionateScreenWidth(
                                                120),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Image.network(
                                                      root_pic +
                                                          projectSnap
                                                              .data[index]
                                                              .image,
                                                      color: kPrimaryColor
                                                          .withOpacity(0.5)),
                                                  height:
                                                      getProportionateScreenWidth(
                                                          40),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          40),
                                                ),

                                                // Icon(
                                                //   Icons.home_work_outlined,
                                                //   color: kPrimaryColor
                                                //       .withOpacity(0.5),
                                                //   size:
                                                //       getProportionateScreenWidth(
                                                //           40),
                                                // ),
                                                Text(
                                                  projectSnap.data[index].title,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                            future: moreServices,
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
