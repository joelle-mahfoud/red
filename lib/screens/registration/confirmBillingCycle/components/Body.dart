import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/ArgumentsData.dart';
import 'package:redcircleflutter/screens/registration/SubmitApplicationWithoutRegisteration.dart';
import 'package:redcircleflutter/screens/registration/assistance/assistance.dart';
import 'package:redcircleflutter/screens/registration/confirmBillingCycle/components/Radio.dart';
import 'package:redcircleflutter/screens/registration/membershipApplication_About/membership_application_about.dart';
import 'package:redcircleflutter/size_config.dart';

class Body extends StatefulWidget {
  final ArgumentsData argumentsData;
  const Body({Key key, this.argumentsData}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     trial = trial;
    //   });
    // });
  }

  bool firstLoad = true;
  String packageId;
  String price;
  String trial = "0";
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM dd,yyyy');
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                getProportionateScreenWidth(SizeConfig.screenWidth * 0.03)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kPrimaryColor,
              height:
                  getProportionateScreenHeight(SizeConfig.screenHeight * 0.03),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: RadioConfirmBillingCycle(
                  cardId: widget.argumentsData.id,
                  onpackageIdChanged: (newpackageId) {
                    packageId = newpackageId;
                  },
                  onPriceChanged: (newPrice) {
                    price = newPrice;
                  },
                  onTrialChanged: (newtrial) {
                    // trial = newtrial;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        trial = newtrial;
                      });
                    });
                    // if (!firstLoad) {
                    // setState(() {
                    //   trial = newtrial;
                    // });
                    // }
                    // firstLoad = false;
                  },
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Expanded(
              flex: 2,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your free trial begins on " +
                        formatter.format(DateTime.now()) +
                        " \nand will end on " +
                        formatter.format(new DateTime(
                            DateTime.now().year,
                            DateTime.now().month + int.parse(trial),
                            DateTime.now().day)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    "You can cancel anytime before " +
                        formatter.format(new DateTime(
                            DateTime.now().year,
                            DateTime.now().month + int.parse(trial),
                            DateTime.now().day)) +
                        " \nto avoid being charged and we'll send an email reminder 3 days befor the trial ends.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Assistance.routeName),
                    child: Text(
                      "Require assistance?",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            InkWell(
              onTap: () {
                if (widget.argumentsData.withregistration) {
                  if (packageId != null) {
                    Navigator.pushNamed(
                        context, MembershipApplicationAbout.routeName,
                        arguments: packageId);
                  }
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubmitApplicationWithoutRegisteration(
                          packageid: packageId,
                          totalPrice: price,
                        ),
                      ));
                }
              },
              child: Container(
                // height: getProportionateScreenHeight(
                //     SizeConfig.screenHeight * 0.07),
                width:
                    getProportionateScreenWidth(SizeConfig.screenWidth * 0.85),
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
                        text: "CONTINUE   ",
                        style: TextStyle(
                            color: Color.fromRGBO(22, 22, 23, 0.8),
                            fontFamily: "Raleway",
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.w600),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: Color.fromRGBO(22, 22, 23, 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04)
          ],
        ),
      ),
    );
  }
}
