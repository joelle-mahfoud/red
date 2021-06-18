import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/size_config.dart';

class RequestCard extends StatefulWidget {
  final String id;
  final String title, subtitle, description, date, subdesc, status;
  final String mainImage;
  final String price;
  final bool withPaybutton;
  final bool isLastCard;
  final Function press;

  const RequestCard(
      {Key key,
      this.id,
      this.title,
      this.subtitle,
      this.date,
      this.subdesc,
      this.description,
      this.status,
      this.mainImage,
      this.price,
      this.withPaybutton = false,
      this.isLastCard = false,
      this.press})
      : super(key: key);

  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15, top: 15),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 0.2,
          color: widget.isLastCard
              ? Colors.transparent
              : Colors.white.withOpacity(0.5), // kPrimaryColor,
        ),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4.0),
            child: Image.network(
              root_pic + widget.mainImage,
              fit: BoxFit.cover,
            ),
            height: getProportionateScreenWidth(60),
            width: getProportionateScreenWidth(70),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 4.0),
          //   child: Image(
          //     height: getProportionateScreenHeight(60),
          //     width: getProportionateScreenWidth(70),
          //     image: AssetImage('assets/images/Background.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SizedBox(
            width: getProportionateScreenWidth(15),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(17),
                      fontWeight: FontWeight.w200),
                ),
                Visibility(
                  visible: (widget.subtitle != null && widget.subtitle != ""),
                  child: Text(
                    widget.subtitle == null ? '' : widget.subtitle,
                    // maxLines: 2,
                    // softWrap: true,
                    // overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(15),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Visibility(
                  visible: (widget.status != null && widget.status != ""),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Status: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionateScreenWidth(15)),
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.status,
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: getProportionateScreenWidth(15))),
                        ],
                      ),
                    ),
                  ),
                  // Text(
                  //   "Status:" + widget.status == null ? '' : widget.status,
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: getProportionateScreenWidth(16),
                  //       fontWeight: FontWeight.w300),
                  // ),
                ),
                Visibility(
                  visible:
                      (widget.description != null && widget.description != ""),
                  child: Text(
                    widget.description == null ? '' : widget.description,
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Visibility(
                    visible: (widget.date != null && widget.date != ""),
                    child: Text(
                      widget.date == null ? '' : widget.date,
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.w300),
                    )),
                Visibility(
                    visible: (widget.subdesc != null && widget.subdesc != ""),
                    child: Text(
                      widget.subdesc == null ? '' : widget.subdesc,
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.w300),
                    )),
                Visibility(
                  visible: (widget.price != null || widget.withPaybutton),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: getProportionateScreenWidth(20),
                        bottom: getProportionateScreenWidth(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.price == null
                                  ? "0"
                                  : widget.price.toString()) +
                              " EUR",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.w300),
                        ),

                        InkWell(
                          onTap: widget.press,
                          child: Container(
                            height: getProportionateScreenHeight(40),
                            width: getProportionateScreenWidth(100),
                            // padding: EdgeInsets.symmetric(
                            //     vertical: getProportionateScreenHeight(
                            //         SizeConfig.screenHeight * 0.02)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: Color.fromRGBO(171, 150, 94, 1),
                                  width: 0.8),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "PAY ",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: "Raleway",
                                        fontSize:
                                            getProportionateScreenWidth(14),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 15,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Text(
                        //     widget.rightDesc,
                        //     // 'Four Seasons aaa',
                        //     textAlign: TextAlign.start,
                        //     style: TextStyle(
                        //         color: kPrimaryColor,
                        //         fontSize: getProportionateScreenWidth(15),
                        //         fontWeight: FontWeight.w300),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
