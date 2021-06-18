import 'package:flutter/material.dart';

class Amenity {
  final String id;
  final String name, image;

  Amenity({@required this.id, @required this.name, @required this.image});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
        id: json['id'], name: json['title_en'], image: json['main_img']);
  }
}

String amenitiesDummyData = '['
    '{'
    '"id": 1,'
    '"name": "Hot Tub"'
    '},'
    '{'
    '"id": 2,'
    '"name": "Pool"'
    '},'
    '{'
    '"id": 3,'
    '"name": "Gym"'
    '},'
    '{'
    '"id": 4,'
    '"name": "Cinema"'
    '},'
    '{'
    '"id": 5,'
    '"name": "Helipad"'
    '},'
    '{'
    '"id": 6,'
    '"name": "Pool"'
    '},'
    '{'
    '"id": 7,'
    '"name": "Hot Tub"'
    '},'
    '{'
    '"id": 8,'
    '"name": "Helipad"'
    '},'
    '{'
    '"id":9,'
    '"name": "Gym"'
    '}'
    ']';
