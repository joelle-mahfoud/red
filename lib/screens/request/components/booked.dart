import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/requestCard.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Booking.dart';
import 'package:redcircleflutter/screens/BookingServices/components/Booking_description.dart';
import 'package:redcircleflutter/screens/offers/components/offer_description.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booked extends StatefulWidget {
  Booked({Key key}) : super(key: key);

  @override
  _BookedState createState() => _BookedState();
}

class _BookedState extends State<Booked> {
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
        "&status=3";
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
        _refreshController.loadComplete();
        return services;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }
  // Future<List<Booking>> fetchBooking() async {
  //   // return (json.decode(bookedDummyData) as List)
  //   //     .map((i) => Booking.fromJson(i))
  //   //     .toList();

  //   final response =
  //       await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  //   if (response.statusCode == 200) {
  //     return (json.decode(bookedDummyData) as List)
  //         .map((i) => Booking.fromJson(i))
  //         .toList();

  //     // return (jsonDecode(response.body) as List)
  //     //     .map((i) => Booking.fromJson(i))
  //     //     .toList();
  //   } else {
  //     throw Exception('Failed to load Booked');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    futureBooking = fetchBooking();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      enablePullUp: true,
      child: Container(
        color: KBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Upcoming bookings",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: getProportionateScreenWidth(18)),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none &&
                      projectSnap.hasData == null) {
                    //print('project snapshot data is: ${projectSnap.data}');
                    return Center(child: CircularProgressIndicator());
                  } else if (projectSnap.hasData) {
                    return ListView.builder(
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        Booking booking = projectSnap.data[index];
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        return RequestCard(
                            id: booking.id,
                            title: booking.title,
                            mainImage: booking.mainImg,
                            description: booking.description,
                            subtitle: booking.subtitle,
                            date: formatter.format(booking.startDate),
                            subdesc: booking.subdesc,
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
                            });
                      },
                    );
                  }
                  return Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        "There are no booked requests!",
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
      ),
    );
  }
}
