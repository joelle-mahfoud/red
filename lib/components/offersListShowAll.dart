import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/models/Offer.dart';
import 'package:redcircleflutter/screens/BookingServices/components/Booking_description.dart';
import 'package:redcircleflutter/size_config.dart';

class OffersListShowAll extends StatefulWidget {
  final int serviceId;
  const OffersListShowAll({
    Key key,
    this.serviceId,
  }) : super(key: key);

  @override
  _OffersListShowAllState createState() => _OffersListShowAllState();
}

class _OffersListShowAllState extends State<OffersListShowAll> {
  Future<List<Offer>> offer;
  @override
  void initState() {
    super.initState();
    offer = fetchOffers();
  }

  Future<List<Offer>> fetchOffers() async {
    String url = root +
        "/" +
        const_get_services_listing +
        "?token=" +
        token +
        "&id=" +
        widget.serviceId.toString();
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<Offer> services =
            (res['data'] as List).map((i) => Offer.fromJson(i)).toList();
        return services;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(SizeConfig.screenWidth * 0.01),
      ),
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none &&
                  projectSnap.hasData == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (projectSnap.hasData) {
                  return GridView.builder(
                      itemCount: projectSnap.data.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: SizeConfig.screenWidth / 2,
                        childAspectRatio: 0.8,
                        // SizeConfig.screenWidth /(SizeConfig.screenHeight / 2),
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctx, index) {
                        return OfferCard(
                          offer: projectSnap.data[index],
                          // image: "assets/images/Background.png",
                          // name: projectSnap.data[index].name,
                          // location: projectSnap.data[index].location,
                          // time: projectSnap.data[index].time,
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDescription(
                                    productId: projectSnap.data[index].id),
                              )),
                        );
                      });
                } else
                  return Container();
              }
            },
            future: offer,
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;
  const OfferCard({
    Key key,
    @required this.offer,
    @required this.press,
  }) : super(key: key);

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
      child: InkWell(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(210),
          height: getProportionateScreenWidth(200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.network(
                    root_pic + offer.mainImg,
                    fit: BoxFit.cover,
                  ),
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.15),
                  width: getProportionateScreenWidth(
                      SizeConfig.screenHeight * 0.5),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: offer.name + "\n", // "$. name\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(17),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: offer.location + "\n"), //  "$location\n"),
                        // TextSpan(text: offer.offerExpiryDate) // "$time")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
