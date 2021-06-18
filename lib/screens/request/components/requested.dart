// import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/requestCard.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Booking.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// status from 1 to 5
// 1 Request
// 2 Approve
// 3 Booked
// 4 Expired
// 5 Canceled

class Requested extends StatefulWidget {
  Requested({Key key}) : super(key: key);

  @override
  _RequestedState createState() => _RequestedState();
}

class _RequestedState extends State<Requested> {
  Future<List<Booking>> futureBooking;
  var jsonpost;

  Future<List<Booking>> fetchBooking() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);

    //http://192.168.0.112:8383/redcircle/web/api/get_bookings.php?token=rb115oc-Rcas|Kredcircleu&client_id=18&status=1
    String url = root +
        "/" +
        const_get_bookings +
        "?token=" +
        token +
        "&client_id=" +
        clientId.toString() +
        "&status=1";
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
  //   // return (json.decode(requestedDummyData) as List)
  //   //     .map((i) => Booking.fromJson(i))
  //   //     .toList();

  //   final response =
  //       await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  //   if (response.statusCode == 200) {
  //     return (json.decode(requestedDummyData) as List)
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "New Requests",
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
                  return Center(child: CircularProgressIndicator());
                } else if (projectSnap.hasData) {
                  return ListView.builder(
                    itemCount: projectSnap.data.length,
                    itemBuilder: (context, index) {
                      Booking booking = projectSnap.data[index];
                      return RequestCard(
                          id: booking.id,
                          title: booking.title,
                          subtitle: booking.subtitle,
                          status: booking.status,
                          isLastCard: (index == projectSnap.data.length - 1),
                          mainImage: booking.mainImg);
                    },
                  );
                }
                return Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      "There are no requests!",
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

// // import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:redcircleflutter/components/requestCard.dart';
// import 'package:redcircleflutter/models/Booking.dart';

// import '../../../constants.dart';
// import '../../../size_config.dart';

// Future<List<Booking>> fetchBooking() async {
//   // return (json.decode(requestedDummyData) as List)
//   //     .map((i) => Booking.fromJson(i))
//   //     .toList();

//   final response =
//       await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
//   if (response.statusCode == 200) {
//     return (json.decode(requestedDummyData) as List)
//         .map((i) => Booking.fromJson(i))
//         .toList();

//     // return (jsonDecode(response.body) as List)
//     //     .map((i) => Booking.fromJson(i))
//     //     .toList();
//   } else {
//     throw Exception('Failed to load.');
//   }
// }

// class Requested extends StatefulWidget {
//   Requested({Key key}) : super(key: key);

//   @override
//   _RequestedState createState() => _RequestedState();
// }

// class _RequestedState extends State<Requested> {
//   Future<List<Booking>> futureBooking;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       futureBooking = fetchBooking();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: KBackgroundColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 15, bottom: 10),
//             child: Text(
//               "New Requests",
//               style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: getProportionateScreenWidth(18)),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder(
//               builder: (context, projectSnap) {
//                 if (projectSnap.connectionState == ConnectionState.none &&
//                     projectSnap.hasData == null) {
//                   return Container();
//                 } else if (projectSnap.hasData) {
//                   return ListView.builder(
//                     itemCount: projectSnap.data.length,
//                     itemBuilder: (context, index) {
//                       Booking booking = projectSnap.data[index];
//                       return RequestCard(
//                           id: booking.id,
//                           title: booking.title,
//                           subtitle: booking.subtitle,
//                           status: booking.status,
//                           isLastCard: (index == projectSnap.data.length - 1),
//                           images: "");
//                     },
//                   );
//                 }
//                 return Center(child: CircularProgressIndicator());
//               },
//               future: futureBooking,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
