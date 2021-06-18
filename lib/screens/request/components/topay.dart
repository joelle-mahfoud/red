import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/requestCard.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Booking.dart';
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

  Future<bool> updateBookingStatus(String bookingId) async {
    //http://192.168.0.112:8383/redcircle/web/api/update_booking.php?token=rb115oc-Rcas|Kredcircleu&id=14&status=3
    dynamic response;
    print(root +
        "/" +
        const_update_booking +
        "?token=" +
        token +
        "&id=" +
        bookingId +
        "&status=3");
    try {
      response = await http.post(
        Uri.parse(root +
            "/" +
            const_update_booking +
            "?token=" +
            token +
            "&id=" +
            bookingId +
            "&status=3"),
        headers: {"Accept": "application/json"},
      );
    } catch (e) {
      print(e);
    }
    print(" ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['result'] == 1) {
        return true;
      } else {
        print(" ${res['message']}");
        return false;
      }
    } else
      return false;
  }

  Future<bool> onupdateStatus(String bookingID) async {
    if (await updateBookingStatus(bookingID)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
                            press: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Confirmation',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  content: Text(
                                    'Do you sure?',
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
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async => {
                                        await onupdateStatus(booking.id),
                                        Navigator.of(context).pop(false),
                                        futureBooking = fetchBooking(),
                                        setState(() {
                                          futureBooking = futureBooking;
                                        })
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
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
