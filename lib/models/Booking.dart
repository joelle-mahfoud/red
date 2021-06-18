import 'dart:convert';

import 'package:flutter/material.dart';

class Booking {
  final String id;
  final String title,
      subtitle,
      description,
      startDate,
      endDate,
      subdesc,
      status;
  final String mainImg;
  final String unitPrice;
  final bool withPaybutton;
  final String createdDate;
  final String quantity;
  final String totalPrice;
  Booking(
      {@required this.id,
      @required this.title,
      this.mainImg,
      this.subtitle,
      this.description,
      this.startDate,
      this.endDate,
      this.subdesc,
      this.status,
      this.unitPrice,
      this.withPaybutton,
      this.createdDate,
      this.quantity,
      this.totalPrice});

// :[{"id":"9","title":"Azimut Magellano","created_date":"2021-06-09","clientname":"Rawan rawan","createname":null,"start_date":"2021-06-09","end_date":"2021-06-30"
// ,"unit_price":"500","quantity":"3","total_price":"1200","status":"Request"}]

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      title: json['title'],
      mainImg: json['main_img'],
      // subtitle: json['subtitle'],
      status: json['status'],
      // description: json['description'],
      // subdesc: json['subdesc'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      quantity: json['quantity'],
      createdDate: json['created_date'],
      unitPrice: json["unit_price"],
      totalPrice: json["total_price"],
      withPaybutton: (json['status'] == "Approve") ? true : false,
    );
  }
}

// {
//   "key": "message",
//   "texts": [
//     {
//       "lan": "en",
//       "text": "You have pushed this button many times"
//     },
//     {
//       "lan": "tr",
//       "text": "Bu butona bir çok kez bastınız"
//     },
//     {
//       "lan": "ru",
//       "text": "Вы много раз нажимали кнопку"
//     }
//   ]
// }

class CalanderBooking1 {
  final Map<String, dynamic> res;
  CalanderBooking1({this.res});

  factory CalanderBooking1.fromJson(Map<String, dynamic> json) {
    return CalanderBooking1(res: jsonDecode(json.toString()));
  }
}

class CalanderBooking {
  final String date;
  final List<Booking> bookings;
  CalanderBooking({this.date, this.bookings});

  factory CalanderBooking.fromJson(Map<String, dynamic> json) {
    return CalanderBooking(date: json['date'], bookings: json['bookings']);
  }
}

String calendarBookingval1 =
    '{"2021-06-11",[{ "id": "1", "title": "title1" }, { "id": "2", "title": "title2" },' +
        '{ "id": "3", "title": "title3" }]}';

String calendarBookingval =
    '{"data":[{"date": "2021-06-11","bookings": [ { "id": "1", "title": "title1" }, { "id": "2", "title": "title2" },' +
        '{ "id": "3", "title": "title3" }]}],"result":1,"message":"All Bookings"}';

List<Booking> calanderBooking = [
  Booking(
      id: "1",
      mainImg: "assets/images/ps4_console_white_1.png",
      title: "8:00 pm",
      description: "Flight To Moscow, Okhotny Ryad, 2",
      withPaybutton: false),
  Booking(
    id: "2",
    mainImg: "assets/images/Image Popular Product 2.png",
    title: "8:00 pm",
    description: "Four Seasons Hotel Moscow, Okhotny Ryad, 2",
    withPaybutton: false,
  ),
];

String bookedDummyData = '['
    '{'
    '"id": 1,'
    '"title": "Chalet Booking",'
    '"subtitle": "in 30 days",'
    '"description": "Chalet Aura",'
    '"date":"Dates: 31.12.2020-09.01.2021",'
    '"subdesc":"Travel Documents"'
    '},'
    '{'
    '"id": 2,'
    '"title": "Chalet Booking",'
    '"subtitle": "in 147 days",'
    '"description": "Chalet Aura",'
    '"date":"Dates: 26.04.2021-10.05.2021",'
    '"subdesc":"Travel Documents"'
    '},'
    '{'
    '"id": 3,'
    '"title": "Yacht Booking",'
    '"subtitle": "in 148 days",'
    '"description": "YachatLuna",'
    '"date":"Dates: 2704.2021-05.05.2021",'
    '"subdesc":"Travel Documents"'
    '}'
    ']';

String toPayDummyData = '['
    '{'
    '"id": 1,'
    '"title": "Car transfer",'
    '"subtitle": "Nice - Monaco, 04.12.20 20:00",'
    '"price": 300'
    '},'
    '{'
    '"id": 2,'
    '"title": "Car transfer",'
    '"subtitle": "Nice - Monaco, 04.12.20 20:00",'
    '"price": 300'
    '}'
    ']';

String requestedDummyData = '['
    '{'
    '"id": 1,'
    '"title": "Book A Table",'
    '"subtitle": "For 4 At METROPOLE MONTECARLO Monaco. 04.12.20 12:00",'
    '"status": "in process"'
    '},'
    '{'
    '"id": 2,'
    '"title": "Book A Table",'
    '"subtitle": "Book A Chalet_ . 01.01.21- 09.1.21",'
    '"status": "to confirm"'
    '}'
    ']';

String moreServices = '['
    '{'
    '"id": 1,'
    '"title": "Chalet Booking"'
    '},'
    '{'
    '"id": 2,'
    '"title": "Sport Events"'
    '},'
    '{'
    '"id": 3,'
    '"title": "Shopping"'
    '},'
    '{'
    '"id": 4,'
    '"title": "Air Tickets"'
    '},'
    '{"id": 5,'
    '"title": "VIP Halls"'
    '},'
    '{'
    '"id": 6,'
    '"title": "Restaurant Night club Reservation"'
    '},'
    '{'
    '"id": 7,'
    '"title": "theatre Concert Tickets"'
    '}'
    ']';

String mainServices = '['
    '{'
    '"id": 1,'
    '"title": "Villa/Chalet booking"'
    '},'
    '{'
    '"id": 2,'
    '"title": "Hotel Bookking"'
    '}'
    ']';
