import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/size_config.dart';

class OfferDescription extends StatefulWidget {
  @override
  _OfferDescriptionState createState() => _OfferDescriptionState();
}

class _OfferDescriptionState extends State<OfferDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
        ),
      ),
      body: Hero(
        tag: 'id:1',
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: getProportionateScreenHeight(200),
                width: double.infinity,
                child:
                    Stack(alignment: AlignmentDirectional.topStart, children: [
                  Carousel(
                    images: [
                      ExactAssetImage("assets/images/PLATIMUM.png"),
                      ExactAssetImage("assets/images/BLACK.png"),
                      ExactAssetImage("assets/images/PLATIMUM.png"),
                      ExactAssetImage("assets/images/BLACK.png")
                    ],
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    dotColor: KBackgroundColor,
                    dotIncreasedColor: kPrimaryColor,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: false,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: kPrimaryColor,
                      size: getProportionateScreenWidth(40),
                    ),
                  ),
                ])),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your winter escape to France",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: getProportionateScreenHeight(20)),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        "Limited time",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        "Dummy data is mock data generated at random as a substitute for live data in testing environments. In other words, dummy data acts as a placeholder for live data, the latter of which testers only introduce once it's determined that the trail program does not have any unintended, negative impact on the underlying data. \n\n Dummy data is mock data generated at random as a substitute for live data in testing environments. In other words, dummy data acts as a placeholder for live data, the latter of which testers only introduce once it's determined that the trail program does not have any unintended, negative impact on the underlying data.  ",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Container(
                  // height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.85),
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(
                          SizeConfig.screenHeight * 0.02)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: KBorderColor,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "SEND TO PA ",
                          style: TextStyle(
                              color: Color.fromRGBO(22, 22, 23, 0.8),
                              fontFamily: "Raleway",
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.w600),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.subdirectory_arrow_right_sharp,
                            size: 18,
                            color: Color.fromRGBO(22, 22, 23, 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
          ],
        )),
      ),
    );
  }
}
