import 'package:flutter/material.dart';

class Service {
  final String id;
  final String title, image;
  final bool isMain;
  final int subservicecount;

  Service(
      {@required this.id,
      @required this.title,
      this.image,
      this.isMain,
      this.subservicecount});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        id: json['id'],
        title: json['title_en'],
        image: json['main_img'],
        isMain: (json['is_featured'] == "1"),
        subservicecount: json['subservicecount']);
  }
}

String serviceDummyData = '['
    '{'
    '"id": 1,'
    '"title": "Villa/Chalet Booking",'
    '"isMain": "true"'
    '},'
    '{'
    '"id": 2,'
    '"title": "Hotel Booking",'
    '"isMain": "true"'
    '},'
    '{'
    '"id": 3,'
    '"title": "Yachts",'
    '"isMain": "false"'
    '},'
    '{'
    '"id": 4,'
    '"title": "Sport Events",'
    '"isMain": "false"'
    '},'
    '{'
    '"id": 5,'
    '"title": "Air Tickets",'
    '"isMain": "false"'
    '},'
    '{'
    '"id": 6,'
    '"title": "Shopping",'
    '"isMain": "false"'
    '},'
    '{'
    '"id": 7,'
    '"title": "VIP Halls",'
    '"isMain": "false"'
    '},'
    '{'
    '"id": 8,'
    '"title": "Restaurant/Night Club Reservation",'
    '"isMain": "false"'
    '},'
    '{'
    '"id": 9,'
    '"title": "Theatre/Concert Tickets",'
    '"isMain": "false"'
    '}'
    ']';

class SubService {
  final String id;
  final String title;

  SubService({@required this.id, @required this.title});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(id: json['id'], title: json['title_en']);
  }
}

String subserviceDummyData = '['
    '{'
    '"id": 1,'
    '"title": "CHALLET COLLECTION"'
    '},'
    '{'
    '"id": 2,'
    '"title": "VILLA COLLECTION"'
    '},'
    '{'
    '"id": 3,'
    '"title": "SUGGESTED FOR YOU"'
    '}'
    ']';
