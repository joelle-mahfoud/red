import 'package:flutter/material.dart';
import 'package:redcircleflutter/models/Amenity.dart';
import 'package:redcircleflutter/models/Booking.dart';

class Offer {
  final String id,
      name,
      mainService,
      subService,
      mainImg,
      location,
      longitude,
      latitude,
      bedrooms,
      guests,
      garage,
      area,
      distanceFromSlopes,
      descriptionEn,
      isOffer,
      offerExpiryDate,
      price,
      floorPlan,
      isFeatured;

  Offer(
      {@required this.id,
      @required this.name,
      this.mainService,
      this.subService,
      this.mainImg,
      this.location,
      this.longitude,
      this.latitude,
      this.bedrooms,
      this.guests,
      this.garage,
      this.area,
      this.distanceFromSlopes,
      this.descriptionEn,
      this.isOffer,
      this.offerExpiryDate,
      this.price,
      this.floorPlan,
      this.isFeatured});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      mainService: json['main_service'],
      subService: json['sub_service'],
      mainImg: json['main_img'],
      name: json['title_en'],
      location: json['location'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      bedrooms: json['bedrooms'],
      guests: json['guests'],
      garage: json['garage'],
      area: json['area'],
      distanceFromSlopes: json['distance_from_slopes'],
      descriptionEn: json['description_en'],
      isOffer: json['is_offer'],
      offerExpiryDate: json['offer_expiry_date'],
      price: json['price'],
      floorPlan: json['floor_plan'],
      isFeatured: json['is_featured'],
    );
  }
}

class OfferImages {
  final String id, imgData;
  OfferImages({@required this.id, @required this.imgData});
  factory OfferImages.fromJson(Map<String, dynamic> json) {
    return OfferImages(id: json['id'], imgData: json['img_data']);
  }
}

// {
//   "2014-12-01": [
//     {
//       "StartTime": "10:00",
//       "EndTime": "16:00"
//     }
//   ],
//   "2014-12-02": [
//     {
//       "StartTime": "12:00",
//       "EndTime": "18:00"
//     }
//   ],
//   "2014-12-03": [
//     {
//       "StartTime": "10:00",
//       "EndTime": "20:00"
//     },
//     {
//       "StartTime": "12:00",
//       "EndTime": "20:00"
//     }
//   ]
// }
class CalendarData {
  final List<Booking> bookings;
  CalendarData({this.bookings});
}

class OfferDetail {
  final String id,
      name,
      mainService,
      subService,
      mainImg,
      location,
      longitude,
      latitude,
      bedrooms,
      guests,
      garage,
      area,
      distanceFromSlopes,
      descriptionEn,
      isOffer,
      offerExpiryDate,
      price,
      floorPlan,
      isFeatured;

  final List<OfferImages> data;
  final List<Amenity> amenities;

  OfferDetail(
      {@required this.id,
      @required this.name,
      this.mainService,
      this.subService,
      this.mainImg,
      this.location,
      this.longitude,
      this.latitude,
      this.bedrooms,
      this.guests,
      this.garage,
      this.area,
      this.distanceFromSlopes,
      this.descriptionEn,
      this.isOffer,
      this.offerExpiryDate,
      this.price,
      this.floorPlan,
      this.isFeatured,
      this.data,
      this.amenities});

  factory OfferDetail.fromJson(Map<String, dynamic> json) {
    List<OfferImages> offerImages =
        (json['data'] as List).map((i) => OfferImages.fromJson(i)).toList();
    List<Amenity> amy = (json['amenities'] == null)
        ? []
        : (json['amenities'] as List).map((i) => Amenity.fromJson(i)).toList();
    return OfferDetail(
      id: json['id'],
      mainService: json['main_service'],
      subService: json['sub_service'],
      mainImg: json['main_img'],
      name: json['title_en'],
      location: json['location'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      bedrooms: json['bedrooms'],
      guests: json['guests'],
      garage: json['garage'],
      area: json['area'],
      distanceFromSlopes: json['distance_from_slopes'],
      descriptionEn: json['description_en'],
      isOffer: json['is_offer'],
      offerExpiryDate: json['offer_expiry_date'],
      price: json['price'],
      floorPlan: json['floor_plan'],
      isFeatured: json['is_featured'],
      data: offerImages,
      amenities: amy,
    );
  }
}

String offersDummyData = '['
    '{'
    '"id": 1,'
    '"name": "Chalet Le Moluse",'
    '"location": "Chamonix",'
    '"time": "Limited time"'
    '},'
    '{'
    '"id": 2,'
    '"name": "Chalet Venice",'
    '"location": "Courchevel",'
    '"time": "Limited time"'
    '}'
    ']';
