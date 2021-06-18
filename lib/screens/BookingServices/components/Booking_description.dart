import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/chat/screens/ChatScreen.dart';
import 'package:redcircleflutter/components/new_to_redcircle.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Offer.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;

class BookingDescription extends StatefulWidget {
  final String productId;
  // final Offer offer;
  const BookingDescription({@required this.productId});

  @override
  _BookingDescriptionState createState() => _BookingDescriptionState();
}

class _BookingDescriptionState extends State<BookingDescription> {
  // Future<List<Amenity>> amenities;
  // Future<List<Amenity>> fetchAmenities() async {
  //   final response =
  //       await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  //   if (response.statusCode == 200) {
  //     return (json.decode(amenitiesDummyData) as List)
  //         .map((i) => Amenity.fromJson(i))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

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

  @override
  void initState() {
    super.initState();
    // amenities = fetchAmenities();
    offerDetails = fetchofferDetails();
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
                                  //images: [
                                  // ListView.builder(
                                  //     itemCount:
                                  //         projectSnap1.data.data.length,
                                  //     itemBuilder:
                                  //         (BuildContext ctxt, int index) {
                                  //       return Image.network(
                                  //         root_pic +
                                  //             projectSnap1
                                  //                 .data.data[1].imgData,
                                  //       );
                                  //     })

                                  // ExactAssetImage("assets/images/PLATIMUM.png"),
                                  // ExactAssetImage("assets/images/BLACK.png"),
                                  // ExactAssetImage("assets/images/PLATIMUM.png"),
                                  // ExactAssetImage("assets/images/BLACK.png")
                                  //],
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
                                          getProportionateScreenHeight(22)),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      projectSnap1.data.location,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenHeight(16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.location_on_outlined,
                                        size: 23, color: kPrimaryColor),
                                    HyperLink(
                                      title: "VIEW MAP",
                                      titleColor: kPrimaryColor,
                                      fontsize: 15,
                                      fontweight: FontWeight.bold,
                                      // press: () => Navigator.pushNamed(context, About.routeName),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                            width: 0.2,
                                            color: Colors.white,
                                          ),
                                        )),
                                        height:
                                            getProportionateScreenHeight(50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Bedrooms",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Text(projectSnap1.data.bedrooms,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                            width: 0.2,
                                            color:
                                                Colors.white, // kPrimaryColor,
                                          ),
                                        )),
                                        padding: EdgeInsets.only(
                                            left: getProportionateScreenWidth(
                                                20)),
                                        height:
                                            getProportionateScreenHeight(50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Guests",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            Text(projectSnap1.data.guests,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: getProportionateScreenWidth(
                                                20)),
                                        height:
                                            getProportionateScreenHeight(50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Garage",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Text(projectSnap1.data.garage,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                            width: 0.2,
                                            color:
                                                Colors.white, // kPrimaryColor,
                                          ),
                                        )),
                                        height:
                                            getProportionateScreenHeight(50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Area",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Text(projectSnap1.data.area,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: getProportionateScreenWidth(
                                                20)),
                                        height:
                                            getProportionateScreenHeight(50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Distace From Slopes",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Text(
                                                projectSnap1
                                                    .data.distanceFromSlopes,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Text(
                                  "Overview ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize:
                                          getProportionateScreenHeight(20)),
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
                                //   "Dummy data is mock data generated at random as a substitute for live data in testing environments. In other words, dummy data acts as a placeholder for live data, the latter of which testers only introduce once it's determined that the trail program does not have any unintended, negative impact on the underlying data. \n\n Dummy data is mock data generated at random as a substitute for live data in testing environments. In other words, dummy data acts as a placeholder for live data, the latter of which testers only introduce once it's determined that the trail program does not have any unintended, negative impact on the underlying data.  ",
                                //   style: TextStyle(
                                //       color: Colors.white.withOpacity(0.6),
                                //       fontSize: getProportionateScreenHeight(14),
                                //       fontWeight: FontWeight.bold),
                                //),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                  productId:
                                                      projectSnap1.data.id,
                                                  productName:
                                                      projectSnap1.data.name,
                                                )));
                                    // PAChat(
                                    //     productid: projectSnap1.data.id,
                                    //     productName:
                                    //         projectSnap1.data.name)));
                                  },
                                  child: Center(
                                    child: Container(
                                      // height: getProportionateScreenHeight(50),
                                      width: getProportionateScreenWidth(
                                          SizeConfig.screenWidth * 0.85),
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionateScreenHeight(
                                                  SizeConfig.screenHeight *
                                                      0.02)),
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
                                                  color: Color.fromRGBO(
                                                      22, 22, 23, 0.8),
                                                  fontFamily: "Raleway",
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          15),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            WidgetSpan(
                                              child: Icon(
                                                Icons
                                                    .subdirectory_arrow_right_sharp,
                                                size: 18,
                                                color: Color.fromRGBO(
                                                    22, 22, 23, 0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                Text(
                                  "Amenities ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),

                                GridView.builder(
                                    itemCount:
                                        projectSnap1.data.amenities.length,
                                    gridDelegate:
                                        // SliverGridDelegateWithFixedCrossAxisCount(
                                        //     crossAxisCount: 2),
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          SizeConfig.screenWidth / 2,
                                      childAspectRatio: SizeConfig.screenWidth /
                                          (SizeConfig.screenHeight / 10),
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          height:
                                              getProportionateScreenHeight(100),
                                          width:
                                              getProportionateScreenWidth(120),
                                          child: Row(
                                            children: [
                                              Container(
                                                  child: Image.network(
                                                root_pic +
                                                    projectSnap1.data
                                                        .amenities[index].image,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              )),

                                              // Icon(
                                              //   Icons.pool,
                                              //   color: Colors.white,
                                              //   size:
                                              //       getProportionateScreenWidth(
                                              //           18),
                                              // ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        20),
                                              ),
                                              Text(
                                                projectSnap1
                                                    .data.amenities[index].name,
                                                // textAlign: TextAlign.center,
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          14),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),

                                // FutureBuilder(
                                //   builder: (context, projectSnap) {
                                //     if (projectSnap.connectionState ==
                                //             ConnectionState.none &&
                                //         projectSnap.hasData == null) {
                                //       return Container();
                                //     } else if (projectSnap.hasData) {
                                //       return GridView.builder(
                                //           itemCount: projectSnap.data.length,
                                //           gridDelegate:
                                //               // SliverGridDelegateWithFixedCrossAxisCount(
                                //               //     crossAxisCount: 2),
                                //               SliverGridDelegateWithMaxCrossAxisExtent(
                                //             maxCrossAxisExtent:
                                //                 SizeConfig.screenWidth / 2,
                                //             childAspectRatio: SizeConfig
                                //                     .screenWidth /
                                //                 (SizeConfig.screenHeight / 10),
                                //             crossAxisSpacing: 0,
                                //             mainAxisSpacing: 0,
                                //           ),
                                //           physics:
                                //               NeverScrollableScrollPhysics(),
                                //           primary: false,
                                //           shrinkWrap: true,
                                //           itemBuilder:
                                //               (BuildContext ctx, index) {
                                //             return Material(
                                //               color: Colors.transparent,
                                //               child: Container(
                                //                 height:
                                //                     getProportionateScreenHeight(
                                //                         100),
                                //                 width:
                                //                     getProportionateScreenWidth(
                                //                         120),
                                //                 child: Row(
                                //                   children: [
                                //                     Icon(
                                //                       Icons.pool,
                                //                       color: Colors.white,
                                //                       size:
                                //                           getProportionateScreenWidth(
                                //                               18),
                                //                     ),
                                //                     SizedBox(
                                //                       width:
                                //                           getProportionateScreenWidth(
                                //                               20),
                                //                     ),
                                //                     Text(
                                //                       projectSnap
                                //                           .data[index].name,
                                //                       // textAlign: TextAlign.center,
                                //                       maxLines: 2,
                                //                       softWrap: true,
                                //                       overflow:
                                //                           TextOverflow.fade,
                                //                       style: TextStyle(
                                //                         color: Colors.white,
                                //                         fontSize:
                                //                             getProportionateScreenWidth(
                                //                                 14),
                                //                       ),
                                //                     )
                                //                   ],
                                //                 ),
                                //               ),
                                //             );
                                //           });
                                //     }
                                //     return Center(
                                //         child: CircularProgressIndicator());
                                //   },
                                //   future: projectSnap1.data.amenities,
                                // ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      accentColor: Colors.yellow,
                                      unselectedWidgetColor: Colors.white
                                        ..withOpacity(0.8)),
                                  child: ListTileTheme(
                                    contentPadding: EdgeInsets.all(0),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (data[index].children.isEmpty)
                                            return ListTile(
                                                title: Text(
                                              data[index].title,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          18)),
                                            ));
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                width: 0.2,
                                                color: Colors.white,
                                              ),
                                            )),
                                            child: ExpansionTile(
                                                // iconColor: Colors.white,
                                                title: Text(
                                                  data[index].title,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              18)),
                                                ),
                                                children: data[index]
                                                    .children
                                                    .map((e) => ListTile(
                                                          title: Text(
                                                            e.title,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList()),
                                          );
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

class Entry {
  final String title;
  final List<Entry> children;
  const Entry(this.title, [this.children = const <Entry>[]]);
}

const List<Entry> data = <Entry>[
  Entry('Services',
      <Entry>[Entry("service1"), Entry("service2"), Entry("service3")]),
  Entry(
      'Multimedia', <Entry>[Entry("media1"), Entry("media2"), Entry("media3")]),
  Entry('Floor plans', <Entry>[Entry("Plan1"), Entry("Plan2"), Entry("Plan3")]),
];
