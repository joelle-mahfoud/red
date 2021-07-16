import 'package:flutter/material.dart';

class About {
  final String id, name, desc, image;

  About({@required this.id, @required this.name, this.desc, this.image});

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
        id: json['id'],
        name: json['title_en'],
        desc: json['description_en'],
        image: json['main_img']);
  }
}

class CircleCards {
  final String id, name, desc, image;
  CircleCards({@required this.id, @required this.name, this.desc, this.image});
  factory CircleCards.fromJson(Map<String, dynamic> json) {
    return CircleCards(
        id: json['id'],
        name: json['title_en'],
        desc: json['description_en'],
        image: json['main_img']);
  }
}

class Benefits {
  final String id, benefit;
  Benefits({@required this.id, @required this.benefit});
  factory Benefits.fromJson(Map<String, dynamic> json) {
    return Benefits(id: json['id'], benefit: json['benefit']);
  }
}

class Interest {
  final String id, title_en;
  Interest({@required this.id, @required this.title_en});
  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(id: json['id'], title_en: json['title_en']);
  }
}

class Package {
  final String id, cardId, duration, type, freeTrial, price;
  bool isSelected;
  Package(
      {@required this.id,
      @required this.cardId,
      this.duration,
      this.type,
      this.freeTrial,
      this.price,
      this.isSelected});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
        id: json['id'],
        cardId: json['card_id'],
        duration: json['duration'],
        type: json['type'],
        freeTrial: json['free_trial'],
        price: json['price'],
        isSelected: false);
  }
}

class TitleEn {
  final String id, titleEn;
  TitleEn({this.id, this.titleEn});

  factory TitleEn.fromJson(Map<String, dynamic> json) {
    return TitleEn(id: json['id'], titleEn: json['title_en']);
  }
}
