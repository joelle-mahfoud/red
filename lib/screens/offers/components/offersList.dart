import 'package:flutter/material.dart';
import 'package:redcircleflutter/screens/BookingServices/components/Booking_description.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Offer.dart';
import 'package:redcircleflutter/size_config.dart';

class OffersList extends StatefulWidget {
  final String title;
  final Function seeMorePress;
  final List<Offer> offers;
  const OffersList({Key key, this.title, this.seeMorePress, this.offers})
      : super(key: key);

  @override
  _OffersListState createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(SizeConfig.screenWidth * 0.008),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(SizeConfig.screenWidth * 0.05),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: kPrimaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.seeMorePress,
                  child: Text(
                    "See More",
                    style: TextStyle(color: Color(0xFFBBBBBB)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Container(
              height:
                  getProportionateScreenWidth(SizeConfig.screenHeight * 0.3),
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.offers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  // physics: NeverScrollableScrollPhysics(),
                  // primary: false,
                  // shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, index) {
                    return OfferCard(
                      offer: widget.offers[index],
                      // image: "assets/images/Background.png",
                      // name: projectSnap.data[index].name,
                      // location: projectSnap.data[index].location,
                      // time: projectSnap.data[index].time,
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDescription(
                                productId: widget.offers[index].id),
                          )),
                    );
                  })),
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
                  height:
                      getProportionateScreenWidth(SizeConfig.screenWidth * 0.4),
                  width: getProportionateScreenWidth(
                      SizeConfig.screenHeight * 0.4),
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
                Text.rich(
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
                      TextSpan(text: offer.location + "\n"), //  "$location\n"),
                      // TextSpan(text: offer.offerExpiryDate) // "$time")
                    ],
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

// import 'package:flutter/material.dart';
// import '../../../size_config.dart';
// import 'section_title.dart';

// class OffersList extends StatelessWidget {
//   const OffersList({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             right: getProportionateScreenWidth(SizeConfig.screenWidth * 0.05),
//           ),
//           child: SectionTitle(
//             title: "DISCOVER MORE",
//             press: () {},
//           ),
//         ),
//         SizedBox(height: getProportionateScreenWidth(10)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               OfferCard(
//                 image: "assets/images/Background.png",
//                 name: "Villa Domina",
//                 location: "Paris",
//                 time: "Limited time",
//                 press: () {},
//               ),
//               OfferCard(
//                 image: "assets/images/Background.png",
//                 name: "Villa Domina",
//                 location: "Paris",
//                 time: "Limited time",
//                 press: () {},
//               ),
//               OfferCard(
//                 image: "assets/images/Background.png",
//                 name: "Villa Domina",
//                 location: "Paris",
//                 time: "Limited time",
//                 press: () {},
//               ),
//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class OfferCard extends StatelessWidget {
//   const OfferCard({
//     Key key,
//     @required this.name,
//     @required this.image,
//     @required this.location,
//     @required this.time,
//     @required this.press,
//   }) : super(key: key);

//   final String name, image, location, time;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
//       child: GestureDetector(
//         onTap: press,
//         child: SizedBox(
//           width: getProportionateScreenWidth(210),
//           height: getProportionateScreenWidth(200),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   image,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Color(0xFF343434).withOpacity(0.4),
//                         Color(0xFF343434).withOpacity(0.15),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: "$name\n",
//                         style: TextStyle(
//                           fontSize: getProportionateScreenWidth(17),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(text: "$location\n"),
//                       TextSpan(text: "$time")
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
