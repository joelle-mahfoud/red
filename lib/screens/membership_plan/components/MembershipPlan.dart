// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

class MembershipPlan {
  int id;
  String title;
  List<String> itemList;

  MembershipPlan({
    this.id,
    this.title,
    this.itemList,
  });

  static Future<List<MembershipPlan>> getMembershipPlans() async {
    Map<String, dynamic> map = json.decode(
        '{"data":[{"id":"1","title":"BLACK","desc":"€500 monthly/ or €5000 per year&&Direct contact with Personal Assitant&&24/7 concierge&&Preferential Rates&&Increased Rewards 1.2%"},{"id":"2","title":"PLATIMUM","desc":"€300 monthly/ or €3000 per year&&Concierge service during business hours&&Competitive rates&&Rawards 0.8%"}]}');
    List<MembershipPlan> list = [];
    for (var map in map['data']) {
      list.add(MembershipPlan(
          id: int.parse(map['id']),
          title: map['title'],
          itemList: map['desc'].split('&&')));
    }
    return list;

    // var uri = Uri.http('192.168.0.112:8383',
    //     '/sportciety/web/api/sport_category.php?token=sb23oc-Moas|Ksportcietyu');

    // var response = await http.get(uri);
    // List<MembershipPlan> list = [];

    // try {
    //   if (response.statusCode == 200) {
    //     Map<String, dynamic> map = json.decode(response.body);

    //     for (var map in map['data']) {
    //       list.add(MembershipPlan(id: map['id'], title: map['title']));
    //     }
    //   }
    // } catch (e, _) {
    //   debugPrint(e.toString());
    // }
    // return list;
  }
}
