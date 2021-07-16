import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/requestCard.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/models/Booking.dart';
import 'package:redcircleflutter/models/RemainingWallet.dart';
import 'package:redcircleflutter/models/clientReward.dart';
import 'package:redcircleflutter/screens/BookingServices/components/Booking_description.dart';
import 'package:redcircleflutter/screens/offers/components/offer_description.dart';
import 'package:redcircleflutter/screens/wallet/PayByWalletOrReward.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToPay extends StatefulWidget {
  ToPay({Key key}) : super(key: key);

  @override
  _ToPayState createState() => _ToPayState();
}

class _ToPayState extends State<ToPay> {
  Future<List<Booking>> futureBooking;

  Future<List<Booking>> fetchBooking() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    //http://192.168.0.112:8383/redcircle/web/api/get_bookings.php?token=rb115oc-Rcas|Kredcircleu&client_id=18&status=3
    String url = root +
        "/" +
        const_get_bookings +
        "?token=" +
        token +
        "&client_id=" +
        clientId.toString() +
        "&status=2";
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<Booking> services =
            (res['data'] as List).map((i) => Booking.fromJson(i)).toList();
        return services;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  // Future<List<Booking>> fetchBooking() async {
  //   final response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  //   if (response.statusCode == 200) {
  //     return (json.decode(toPayDummyData) as List)
  //         .map((i) => Booking.fromJson(i))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load.');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    futureBooking = fetchBooking();
  }

  final DateFormat formatter = DateFormat('dd.MM.yy');

  @override
  Widget build(BuildContext context) {
    ClientReward clientRewards;
    return Container(
      color: KBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none &&
                    projectSnap.hasData == null) {
                  return Center(child: CircularProgressIndicator());
                } else if (projectSnap.hasData) {
                  return ListView.builder(
                    itemCount: projectSnap.data.length,
                    itemBuilder: (context, index) {
                      Booking booking = projectSnap.data[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: Text(
                              "Bills To Pay Till " +
                                  formatter.format(DateTime.now()), //3.12.20
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: getProportionateScreenWidth(18)),
                            ),
                          ),
                          RequestCard(
                            id: booking.id,
                            title: booking.title,
                            subtitle: booking.subtitle,
                            mainImage: booking.mainImg,
                            price: booking.totalPrice,
                            withPaybutton: true,
                            isLastCard: (index == projectSnap.data.length - 1),
                            onTapCard: () async {
                              (booking.isOffer == null ||
                                      booking.isOffer == "0")
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingDescription(
                                                productId: booking.listingId),
                                      ),
                                    )
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OfferDescription(
                                          productId: booking.listingId,
                                        ),
                                      ));
                            },
                            onPay: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Pay',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  content: Text(
                                    'Select your payment methode:',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  elevation: 100,
                                  backgroundColor: KBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              kPrimaryColor.withOpacity(0.8)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  actions: <Widget>[
                                    InkWell(
                                      onTap: () async {
                                        bool shouldUpdate = await showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                    'Pay',
                                                    style: TextStyle(
                                                        color: kPrimaryColor),
                                                  ),
                                                  content: Text(
                                                    'Are you sure you want pay?',
                                                    style: TextStyle(
                                                        color: kPrimaryColor),
                                                  ),
                                                  elevation: 100,
                                                  backgroundColor:
                                                      KBackgroundColor,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: kPrimaryColor
                                                              .withOpacity(
                                                                  0.8)),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, false),
                                                      child: Text(
                                                        'No',
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        RemainingWallet
                                                            remainingWallet =
                                                            await addWallet(
                                                                0,
                                                                booking.id,
                                                                booking
                                                                    .totalPrice);
                                                        if (remainingWallet !=
                                                                null &&
                                                            remainingWallet
                                                                    .result ==
                                                                1) {
                                                          clientRewards =
                                                              await onAddClientRewards(
                                                                  booking.id,
                                                                  booking
                                                                      .totalPrice);
                                                          if (clientRewards
                                                                  .result ==
                                                              1) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                            futureBooking =
                                                                fetchBooking();
                                                            setState(() {
                                                              futureBooking =
                                                                  futureBooking;
                                                            });
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                  ],
                                                ));

                                        if (shouldUpdate) {
                                          Navigator.of(context).pop(false);
                                          if (clientRewards.amount != 0) {
                                            await showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                        'Reward',
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                      content: Text(
                                                        'You earned ' +
                                                            clientRewards.amount
                                                                .toString() +
                                                            " €",
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                      elevation: 100,
                                                      backgroundColor:
                                                          KBackgroundColor,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: kPrimaryColor
                                                                  .withOpacity(
                                                                      0.8)),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  false),
                                                          child: Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color:
                                                                    kPrimaryColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        }
                                      },
                                      child: Container(
                                        // height: getProportionateScreenWidth(50),
                                        width: getProportionateScreenWidth(
                                            SizeConfig.screenWidth * 0.85),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                getProportionateScreenHeight(
                                                    SizeConfig.screenHeight *
                                                        0.02)),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(5.0)),
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Image(
                                                  height: 20,
                                                  width: 26,
                                                  image: AssetImage(
                                                      'assets/images/pay.png'),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "Pay",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Raleway",
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: getProportionateScreenHeight(
                                            SizeConfig.screenHeight * 0.02)),
                                    InkWell(
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PayByWalletOrReward(
                                                isToPackage: false,
                                                orderId: booking.id,
                                                totalPrice: booking.totalPrice,
                                              ),
                                            ));

                                        // bool shouldUpdate = await showDialog(
                                        //     context: context,
                                        //     barrierDismissible: true,
                                        //     builder: (context) => AlertDialog(
                                        //           title: Text(
                                        //             'Wallet',
                                        //             style: TextStyle(
                                        //                 color: kPrimaryColor),
                                        //           ),
                                        //           content: Text(
                                        //             'Are you sure you want pay?',
                                        //             style: TextStyle(
                                        //                 color: kPrimaryColor),
                                        //           ),
                                        //           elevation: 100,
                                        //           backgroundColor:
                                        //               KBackgroundColor,
                                        //           shape: RoundedRectangleBorder(
                                        //               side: BorderSide(
                                        //                   color: kPrimaryColor
                                        //                       .withOpacity(
                                        //                           0.8)),
                                        //               borderRadius:
                                        //                   BorderRadius.all(
                                        //                       Radius.circular(
                                        //                           10.0))),
                                        //           actions: <Widget>[
                                        //             TextButton(
                                        //               onPressed: () =>
                                        //                   Navigator.of(context)
                                        //                       .pop(),
                                        //               child: Text(
                                        //                 'No',
                                        //                 style: TextStyle(
                                        //                     color:
                                        //                         kPrimaryColor),
                                        //               ),
                                        //             ),
                                        //             TextButton(
                                        //               onPressed: () async => {
                                        //                 await onAddClientRewards(
                                        //                     booking.id,
                                        //                     booking.totalPrice),
                                        //                 Navigator.of(context)
                                        //                     .pop(false),
                                        //                 futureBooking =
                                        //                     fetchBooking(),
                                        //                 setState(() {
                                        //                   futureBooking =
                                        //                       futureBooking;
                                        //                 })
                                        //               },
                                        //               child: Text(
                                        //                 'Yes',
                                        //                 style: TextStyle(
                                        //                     color:
                                        //                         kPrimaryColor),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ));
                                        // Navigator.of(context).pop(false);
                                      },
                                      child: Container(
                                        // height: getProportionateScreenWidth(50),
                                        width: getProportionateScreenWidth(
                                            SizeConfig.screenWidth * 0.85),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                getProportionateScreenHeight(
                                                    SizeConfig.screenHeight *
                                                        0.02)),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  171, 150, 94, 1),
                                              width: 0.8),
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.wallet_travel,
                                                  size: 18,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " Wallet",
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontFamily: "Raleway",
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: getProportionateScreenHeight(
                                            SizeConfig.screenHeight * 0.02)),
                                    // InkWell(
                                    //   onTap: () async {
                                    //     bool shouldUpdate = await showDialog(
                                    //         context: context,
                                    //         barrierDismissible: true,
                                    //         builder: (context) => AlertDialog(
                                    //               title: Text(
                                    //                 'Reward',
                                    //                 style: TextStyle(
                                    //                     color: kPrimaryColor),
                                    //               ),
                                    //               content: Text(
                                    //                 'Are you sure you want pay?',
                                    //                 style: TextStyle(
                                    //                     color: kPrimaryColor),
                                    //               ),
                                    //               elevation: 100,
                                    //               backgroundColor:
                                    //                   KBackgroundColor,
                                    //               shape: RoundedRectangleBorder(
                                    //                   side: BorderSide(
                                    //                       color: kPrimaryColor
                                    //                           .withOpacity(
                                    //                               0.8)),
                                    //                   borderRadius:
                                    //                       BorderRadius.all(
                                    //                           Radius.circular(
                                    //                               10.0))),
                                    //               actions: <Widget>[
                                    //                 TextButton(
                                    //                   // style: ButtonStyle(
                                    //                   //     backgroundColor:
                                    //                   //         MaterialStateProperty.all(
                                    //                   //             Color.fromRGBO(
                                    //                   //                 42, 63, 84, 1))),
                                    //                   onPressed: () =>
                                    //                       Navigator.of(context)
                                    //                           .pop(),
                                    //                   child: Text(
                                    //                     'No',
                                    //                     style: TextStyle(
                                    //                         color:
                                    //                             kPrimaryColor),
                                    //                   ),
                                    //                 ),
                                    //                 TextButton(
                                    //                   // style: ButtonStyle(
                                    //                   //     backgroundColor:
                                    //                   //         MaterialStateProperty.all(
                                    //                   //             Color.fromRGBO(
                                    //                   //                 42, 63, 84, 1))),
                                    //                   onPressed: () async => {
                                    //                     await onAddUsedRewards(
                                    //                         booking.id,
                                    //                         booking.totalPrice),
                                    //                     Navigator.of(context)
                                    //                         .pop(false),
                                    //                     futureBooking =
                                    //                         fetchBooking(),
                                    //                     setState(() {
                                    //                       futureBooking =
                                    //                           futureBooking;
                                    //                     })
                                    //                   },
                                    //                   child: Text(
                                    //                     'Yes',
                                    //                     style: TextStyle(
                                    //                         color:
                                    //                             kPrimaryColor),
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ));
                                    //     Navigator.of(context).pop(false);
                                    //   },
                                    //   child: Container(
                                    //     // height: getProportionateScreenWidth(50),
                                    //     width: getProportionateScreenWidth(
                                    //         SizeConfig.screenWidth * 0.85),
                                    //     padding: EdgeInsets.symmetric(
                                    //         vertical:
                                    //             getProportionateScreenHeight(
                                    //                 SizeConfig.screenHeight *
                                    //                     0.02)),
                                    //     alignment: Alignment.center,
                                    //     decoration: BoxDecoration(
                                    //       color: kPrimaryColor.withOpacity(0.5),
                                    //       border: Border.all(
                                    //           color: kPrimaryColor
                                    //               .withOpacity(0.5),
                                    //           width: 0.8),
                                    //     ),
                                    //     child: RichText(
                                    //       text: TextSpan(
                                    //         children: [
                                    //           WidgetSpan(
                                    //             child: Icon(
                                    //               Icons.redeem,
                                    //               size: 18,
                                    //               color: Colors.white,
                                    //             ),
                                    //           ),
                                    //           TextSpan(
                                    //             text: " Reward",
                                    //             style: TextStyle(
                                    //                 color: Colors.white,
                                    //                 fontFamily: "Raleway",
                                    //                 fontSize:
                                    //                     getProportionateScreenWidth(
                                    //                         15),
                                    //                 fontWeight:
                                    //                     FontWeight.w600),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                return Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      "There are no requests to pay!",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: getProportionateScreenWidth(18)),
                    ));
              },
              future: futureBooking,
            ),
          ),
        ],
      ),
    );
  }
}
