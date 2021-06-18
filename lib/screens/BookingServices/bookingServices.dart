import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/BookingServices/components/body.dart';
import 'package:redcircleflutter/size_config.dart';
import '../../constants.dart';

class Services extends StatelessWidget {
  static String routeName = "/services";
  final int serviceId;
  final int subServiceCount;
  final String title;

  const Services({Key key, this.title, this.serviceId, this.subServiceCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        title: Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenHeight(23),
          ),
        ),
        toolbarHeight: getProportionateScreenHeight(120),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp, color: kPrimaryColor),
          iconSize: 35,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: KBackgroundColor,
          ),
          child: Body(serviceId: serviceId, subServiceCount: subServiceCount),
        ),
      ),
    );
  }
}
