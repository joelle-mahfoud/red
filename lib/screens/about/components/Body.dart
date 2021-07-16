import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/about.dart';
import 'package:redcircleflutter/screens/membership_plan/MemberShipPlan.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<About> futureAbout;
  Future<About> fetchAbout() async {
    String url = root + "/" + const_get_about + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        About about = About.fromJson(res);
        return about;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  Future<List<CircleCards>> futureCircleCards;
  String url = root + "/" + const_get_circle_cards + "?token=" + token;
  Future<List<CircleCards>> fetchCircleCards() async {
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<CircleCards> circleCards =
            (res['data'] as List).map((i) => CircleCards.fromJson(i)).toList();
        // _refreshController.loadComplete();
        return circleCards;
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
    futureAbout = fetchAbout();
    futureCircleCards = fetchCircleCards();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    setState(() {
      futureAbout = fetchAbout();
      futureCircleCards = fetchCircleCards();
    });
    _refreshController.loadComplete();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // void _onRefresh() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use refreshFailed()
  //   setState(() {
  //     futureAbout = fetchAbout();
  //     futureCircleCards = fetchCircleCards();
  //   });

  //   _refreshController.refreshCompleted();
  // }

  @override
  Widget build(BuildContext context) {
    return
        // SmartRefresher(
        //   controller: _refreshController,
        //   onRefresh: _onRefresh,
        //   onLoading: _onLoading,
        //   enablePullDown: true,
        //   enablePullUp: true,
        //   child:
        FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Center(child: new CircularProgressIndicator());
        } else if (projectSnap.hasData) {
          About about = projectSnap.data;
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
                      Container(
                        height: getProportionateScreenHeight(
                            SizeConfig.screenHeight * 0.25),
                        width: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.9),
                        child: Image.network(
                          root_pic + about.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      // 'Welcom to an exclusive lifestyle club designed to be a trusted partner for your life.'
                      Text(about.name,
                          style: TextStyle(
                              color: Color.fromRGBO(251, 255, 255, 1),
                              fontSize: getProportionateScreenWidth(22),
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      Html(
                          data: about.desc,
                          defaultTextStyle: TextStyle(
                              color: Color.fromRGBO(251, 255, 255, 1),
                              fontSize: getProportionateScreenWidth(15))),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      FutureBuilder(
                          future: futureCircleCards,
                          builder: (context, snapshot_Card) {
                            if (snapshot_Card.hasData) {
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: snapshot_Card.data.length,
                                  itemBuilder: (context, i) {
                                    CircleCards circleCards =
                                        snapshot_Card.data[i];
                                    return Column(
                                      children: [
                                        Container(
                                          width:
                                              getProportionateScreenWidth(292),
                                          height:
                                              getProportionateScreenHeight(185),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: Image.network(
                                            root_pic + circleCards.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.03),
                                        Html(
                                            data: circleCards.desc,
                                            defaultTextStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    251, 255, 255, 1),
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15))),
                                        SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.08),
                                      ],
                                    );
                                  });
                            }
                            return Center(
                                child: new CircularProgressIndicator());
                          }),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, MembershipPlan.routeName),
                        child: Container(
                          width: getProportionateScreenWidth(
                              SizeConfig.screenWidth * 0.9),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black, //fromRGBO(35, 31, 32, 1),
                            // borderRadius: BorderRadius.all(Radius.circular(0)),
                            border: Border.all(
                                color: Color.fromRGBO(171, 150, 94, 1),
                                width: 0.8),
                            // color: Color(0xab965e),
                            // width: 0.8),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "NEXT    ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: "Raleway",
                                      fontSize: getProportionateScreenWidth(15),
                                      fontWeight: FontWeight.w600),
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.06),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Center(child: new CircularProgressIndicator());
      },
      future: futureAbout,
    );
    // );
  }

  // @override
  // Widget build(BuildContext context) {
  //   CollectionReference info = FirebaseFirestore.instance.collection('About');
  //   CollectionReference cards =
  //       FirebaseFirestore.instance.collection("Circle_Cards");

  //   return FutureBuilder<DocumentSnapshot>(
  //     future: info.doc('1aFHErUx4HKuFvE5a5ZH').get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text("Something went wrong");
  //       }

  //       if (snapshot.hasData && !snapshot.data.exists) {
  //         return Text("Document does not exist");
  //       }

  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data = snapshot.data.data();
  //         return SafeArea(
  //           child: SizedBox(
  //             width: double.infinity,
  //             child: SingleChildScrollView(
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: getProportionateScreenWidth(25)),
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: SizeConfig.screenHeight * 0.07),
  //                     Container(
  //                       height: getProportionateScreenHeight(
  //                           SizeConfig.screenHeight * 0.25),
  //                       width: getProportionateScreenWidth(
  //                           SizeConfig.screenWidth * 0.9),
  //                       child: Image.network(
  //                         "${data['image']}",
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     SizedBox(height: SizeConfig.screenHeight * 0.03),
  //                     // 'Welcom to an exclusive lifestyle club designed to be a trusted partner for your life.'
  //                     Text(data['title'],
  //                         style: TextStyle(
  //                             color: Color.fromRGBO(251, 255, 255, 1),
  //                             fontSize: getProportionateScreenWidth(22),
  //                             fontWeight: FontWeight.bold)),
  //                     SizedBox(height: SizeConfig.screenHeight * 0.03),
  //                     Html(
  //                         data: data['text'],
  //                         defaultTextStyle: TextStyle(
  //                             color: Color.fromRGBO(251, 255, 255, 1),
  //                             fontSize: getProportionateScreenWidth(15))),
  //                     // RichText(
  //                     //     text: TextSpan(
  //                     //         text: 'RED CIRCLE',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.bold),
  //                     //         children: <TextSpan>[
  //                     //       TextSpan(
  //                     //         text:
  //                     //             ' is the private membership club, offers an array of high-end and high-value services, travel benefits, and loyalty rewards built around the unique needs of each Member.\n\nWe make our clients\' lives easier by providing a single point contact to get access to the best services and products in the whole luxury sector.\n\nWith tow unique members can take experts to help organise peffect weekends or holidays to create memories that last a lifeTime.',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.normal),
  //                     //       )
  //                     //     ])),
  //                     //
  //                     SizedBox(height: SizeConfig.screenHeight * 0.08),

  //                     FutureBuilder(
  //                         future:
  //                             cards.orderBy('order', descending: true).get(),
  //                         // .where("userid",
  //                         //     isEqualTo: FirebaseAuth.instance.currentUser.uid)
  //                         // .get(),
  //                         builder: (context, snapshot) {
  //                           if (snapshot.hasData) {
  //                             return ListView.builder(
  //                                 physics: NeverScrollableScrollPhysics(),
  //                                 primary: false,
  //                                 shrinkWrap: true,
  //                                 itemCount: snapshot.data.docs.length,
  //                                 itemBuilder: (context, i) {
  //                                   return Column(
  //                                     children: [
  //                                       Container(
  //                                         width:
  //                                             getProportionateScreenWidth(292),
  //                                         height:
  //                                             getProportionateScreenHeight(185),
  //                                         decoration: BoxDecoration(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                           boxShadow: [
  //                                             BoxShadow(
  //                                               color: Colors.white
  //                                                   .withOpacity(0.3),
  //                                               blurRadius: 5,
  //                                               offset: Offset(2, 2),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         child: Image.network(
  //                                           "${snapshot.data.docs[i]['image']}",
  //                                           fit: BoxFit.cover,
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                           height:
  //                                               SizeConfig.screenHeight * 0.03),
  //                                       Html(
  //                                           data: snapshot.data.docs[i]
  //                                               ['description'],
  //                                           defaultTextStyle: TextStyle(
  //                                               color: Color.fromRGBO(
  //                                                   251, 255, 255, 1),
  //                                               fontSize:
  //                                                   getProportionateScreenWidth(
  //                                                       15))),
  //                                       SizedBox(
  //                                           height:
  //                                               SizeConfig.screenHeight * 0.08),
  //                                     ],
  //                                   );
  //                                   // return ListNotes(
  //                                   //   notes: snapshot.data.docs[i],
  //                                   //   docid: snapshot.data.docs[i].id,
  //                                   // );
  //                                 });
  //                           }
  //                           return Center(child: CircularProgressIndicator());
  //                         }),

  //                     // Container(
  //                     //   width: getProportionateScreenWidth(292),
  //                     //   height: getProportionateScreenHeight(185),
  //                     //   decoration: BoxDecoration(
  //                     //     borderRadius: BorderRadius.circular(10),
  //                     //     boxShadow: [
  //                     //       BoxShadow(
  //                     //         color: Colors.white.withOpacity(0.3),
  //                     //         blurRadius: 5,
  //                     //         offset: Offset(2, 2),
  //                     //       ),
  //                     //     ],
  //                     //   ),
  //                     //   child: Image(
  //                     //     image: AssetImage('assets/images/PLATIMUM.png'),
  //                     //     fit: BoxFit.cover,
  //                     //   ),
  //                     // ),
  //                     // SizedBox(height: SizeConfig.screenHeight * 0.03),
  //                     // Html(
  //                     //     data: data['description'],
  //                     //     defaultTextStyle: TextStyle(
  //                     //         color: Color.fromRGBO(251, 255, 255, 1),
  //                     //         fontSize: getProportionateScreenWidth(15))),
  //                     // SizedBox(height: SizeConfig.screenHeight * 0.08),

  //                     // RichText(
  //                     //     text: TextSpan(
  //                     //         text: 'The Black',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.bold),
  //                     //         children: <TextSpan>[
  //                     //       TextSpan(
  //                     //         text:
  //                     //             ' is our highest tier of membreship for hight-net-worth individuals that would like a full concierge service with their owner',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.normal),
  //                     //       ),
  //                     //       TextSpan(
  //                     //         text: ' dedicated Lifestyle Manager',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.bold),
  //                     //       ),
  //                     //       TextSpan(
  //                     //         text:
  //                     //             ' (Personal Assistandt)\ngiving you a bespoke one-to-one support and assitance available 24/7.',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.normal),
  //                     //       )
  //                     //     ])),
  //                     // SizedBox(height: SizeConfig.screenHeight * 0.08),
  //                     // Container(
  //                     //   width: getProportionateScreenWidth(292),
  //                     //   height: getProportionateScreenHeight(185),
  //                     //   decoration: BoxDecoration(
  //                     //     borderRadius: BorderRadius.circular(10),
  //                     //     boxShadow: [
  //                     //       BoxShadow(
  //                     //         color: Colors.white.withOpacity(0.3),
  //                     //         blurRadius: 5,
  //                     //         offset: Offset(2, 2),
  //                     //       ),
  //                     //     ],
  //                     //   ),
  //                     //   child: Image(
  //                     //     image: AssetImage('assets/images/PLATIMUM.png'),
  //                     //     fit: BoxFit.cover,
  //                     //   ),
  //                     // ),
  //                     // SizedBox(height: SizeConfig.screenHeight * 0.03),
  //                     // RichText(
  //                     //     text: TextSpan(
  //                     //         text: 'The Platinum',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.bold),
  //                     //         children: <TextSpan>[
  //                     //       TextSpan(
  //                     //         text:
  //                     //             ' is the absic tier of RED CIRCLE.It gives you the right to have access to lifestyle team.available from gam to 6pm(CET time)Monday to Friday to cater for your every need.',
  //                     //         style: TextStyle(
  //                     //             color: Color.fromRGBO(251, 255, 255, 1),
  //                     //             fontSize: getProportionateScreenWidth(15),
  //                     //             fontWeight: FontWeight.normal),
  //                     //       ),
  //                     //     ])),
  //                     SizedBox(height: SizeConfig.screenHeight * 0.04),
  //                     InkWell(
  //                       onTap: () => Navigator.pushNamed(
  //                           context, MembershipPlan.routeName),
  //                       child: Container(
  //                         width: getProportionateScreenWidth(
  //                             SizeConfig.screenWidth * 0.9),
  //                         padding: EdgeInsets.symmetric(vertical: 15),
  //                         alignment: Alignment.center,
  //                         decoration: BoxDecoration(
  //                           color: Colors.black, //fromRGBO(35, 31, 32, 1),
  //                           // borderRadius: BorderRadius.all(Radius.circular(0)),
  //                           border: Border.all(
  //                               color: Color.fromRGBO(171, 150, 94, 1),
  //                               width: 0.8),
  //                           // color: Color(0xab965e),
  //                           // width: 0.8),
  //                         ),
  //                         child: RichText(
  //                           text: TextSpan(
  //                             children: [
  //                               TextSpan(
  //                                 text: "START YOUR FREE 3-MONTH TRIAL    ",
  //                                 style: TextStyle(
  //                                     color: kPrimaryColor,
  //                                     fontFamily: "Raleway",
  //                                     fontSize: getProportionateScreenWidth(15),
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               WidgetSpan(
  //                                 child: Icon(
  //                                   Icons.arrow_forward_ios_outlined,
  //                                   size: 18,
  //                                   color: kPrimaryColor,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: SizeConfig.screenHeight * 0.06),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //       return Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }
}
