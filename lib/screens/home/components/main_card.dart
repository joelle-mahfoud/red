import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/main.dart';
import 'package:redcircleflutter/size_config.dart';

class MainCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final String leftDesc;
  final String rightDesc;
  final bool underline;
  const MainCard(
      {Key key,
      this.title,
      this.iconPath,
      this.subtitle,
      this.leftDesc,
      this.rightDesc,
      this.underline})
      : super(key: key);

  @override
  _MainCardState createState() => _MainCardState();
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(310),
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        // margin: EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0.1,
            color: widget.underline
                ? Colors.white
                : Colors.transparent, // kPrimaryColor,
          ),
        )),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              // "assets/icons/bell.svg",
              "assets/icons/" + widget.iconPath,
              // color: Colors.green,
              height: getProportionateScreenWidth(40),
              // width:
              //     getProportionateScreenWidth(SizeConfig.screenHeight * 0.02),
              // height:
              //     getProportionateScreenWidth(SizeConfig.screenHeight * 0.02),
              // width:
              //     getProportionateScreenWidth(SizeConfig.screenHeight * 0.02),
            ),

            // Icon(
            //   Icons.calendar_today,
            //   color: kPrimaryColor,
            //   size: getProportionateScreenWidth(35),
            // ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: getProportionateScreenWidth(200),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    // 'CALENDER',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionateScreenWidth(25),
                        fontWeight: FontWeight.w200),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Text(
                    removeAllHtmlTags(widget.subtitle),
                    // 'Today, Wed 30 Dec 2020',
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: getProportionateScreenWidth(15),
                        fontWeight: FontWeight.w300),
                  ),
                  Visibility(
                    visible: !(widget.leftDesc == "" && widget.rightDesc == ""),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: kPrimaryColor)),
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: (widget.leftDesc != null &&
                                widget.leftDesc != ""),
                            child: Container(
                              width: getProportionateScreenWidth(40),
                              child: Text(
                                widget.leftDesc == null ? "" : widget.leftDesc,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: (widget.leftDesc != null &&
                                  widget.leftDesc != ""),
                              child: SizedBox(width: 15)),
                          Visibility(
                            visible: (widget.rightDesc != null &&
                                widget.rightDesc != ""),
                            child: Flexible(
                              child: Text(
                                widget.rightDesc == null
                                    ? ""
                                    : widget.rightDesc,
                                // 'Four Seasons aaa',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Image(image: AssetImage('graphics/background.png')),
            Icon(
              Icons.keyboard_arrow_right_sharp,
              color: kPrimaryColor,
              size: getProportionateScreenWidth(40),
            ),
          ],
        ),
      ),
    );
  }
}
