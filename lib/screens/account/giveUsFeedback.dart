import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/models/Feedback.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GiveUsFeedback extends StatefulWidget {
  const GiveUsFeedback({Key key}) : super(key: key);

  @override
  _GiveUsFeedbackState createState() => _GiveUsFeedbackState();
}

class _GiveUsFeedbackState extends State<GiveUsFeedback> {
  final List<String> errors = [];
  String feedbackText;
  String ratingval;
  String initRatingval;
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  final _formKey = GlobalKey<FormState>();

  TextFormField buildfeedbackFormField() {
    return TextFormField(
      minLines: 3,
      maxLines: 10,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (newValue) => feedbackText = newValue,
      onChanged: (value) {
        feedbackText = value;
        // if (value.isNotEmpty) {
        //   removeError(error: kOldPasswordNullError);
        // }
        return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        //   addError(error: kOldPasswordNullError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: KBorderColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow.withOpacity(0.3)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: "Type Your FeedBack here",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<FeedbackClass> futureFeedback;
  Future<FeedbackClass> fetchFeedback() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    //{{url}}/get_last_feedback.php?token={{token}}&client_id=34
    String url = root +
        "/" +
        const_get_last_feedback +
        "?token=" +
        token +
        "&client_id=" +
        clientId;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        FeedbackClass titleEn = FeedbackClass.fromJson(res);
        ratingval = titleEn.stars.toString();
        return titleEn;
      } else {
        ratingval = "3";
        print(" ${res['message']}");
        return null;
      }
    }
    ratingval = "3";
  }

  @override
  void initState() {
    super.initState();
    futureFeedback = fetchFeedback();
  }

  Future<bool> createFeedback(String feedbacktxt, String starts) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    //{{url}}/create_feedback.php?token={{token}}&text=jalal&stars=5&client_id=34
    dynamic response;
    try {
      response = await http.post(
        Uri.parse(root +
            "/" +
            const_create_feedback +
            "?token=" +
            token +
            "&text=" +
            feedbacktxt +
            "&stars=" +
            starts +
            "&client_id=" +
            clientId),
        headers: {"Accept": "application/json"},
      );
    } catch (e) {
      print(e);
    }
    print(root +
        "/" +
        const_create_feedback +
        "?token=" +
        token +
        "&text=" +
        feedbacktxt +
        "&stars=" +
        starts +
        "&client_id=" +
        clientId);
    print(" ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['result'] == 1) {
        return true;
      } else {
        print(" ${res['message']}");
        return false;
      }
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "Give Us Feedback",
          style: TextStyle(color: kPrimaryColor),
        ),
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
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.03)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Form(
                        key: _formKey,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      SizeConfig.screenHeight * 0.01)),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildfeedbackFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      FutureBuilder(
                                        builder: (context, projectSnap) {
                                          double stars = 5;
                                          if (projectSnap.connectionState ==
                                                  ConnectionState.none &&
                                              projectSnap.hasData == null) {
                                            return Center(
                                                child:
                                                    new CircularProgressIndicator());
                                          } else if (projectSnap.hasData) {
                                            FeedbackClass val =
                                                projectSnap.data;
                                            stars = double.parse(val.stars);
                                          }
                                          return RatingBar(
                                            initialRating: stars,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                              full: Icon(
                                                Icons.star,
                                                color: kPrimaryColor,
                                              ),
                                              half: Icon(
                                                Icons.star,
                                                color: kPrimaryColor,
                                              ),
                                              empty: Icon(Icons.star,
                                                  color: Colors.white),
                                            ),
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            onRatingUpdate: (rating) {
                                              ratingval =
                                                  rating.toInt().toString();
                                            },
                                          );
                                        },
                                        future: futureFeedback,
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      FormError(errors: errors),
                                      InkWell(
                                        onTap: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();

                                            setState(() {
                                              errors.clear();
                                            });
                                            KeyboardUtil.hideKeyboard(context);

                                            bool shouldUpdate =
                                                await showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Confirmation',
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                              // content: Text(
                                                              //   'Are you sure you want to change password?',
                                                              //   style: TextStyle(
                                                              //       color:
                                                              //           kPrimaryColor),
                                                              // ),
                                                              elevation: 100,
                                                              backgroundColor:
                                                                  KBackgroundColor,
                                                              shape: RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      color: kPrimaryColor
                                                                          .withOpacity(
                                                                              0.8)),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          false),
                                                                  child: Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () => {
                                                                    createFeedback(
                                                                            feedbackText,
                                                                            ratingval)
                                                                        .then(
                                                                            (value) {
                                                                      if (value)
                                                                        Navigator.pop(
                                                                            context,
                                                                            true);
                                                                      else {
                                                                        Navigator.pop(
                                                                            context,
                                                                            false);
                                                                      }
                                                                    }),
                                                                  },
                                                                  child: Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor),
                                                                  ),
                                                                ),
                                                              ],
                                                            ));
                                            if (shouldUpdate) {
                                              Navigator.pushNamed(context,
                                                  HomeScreen.routeName);
                                            }
                                          }
                                        },
                                        child: Container(
                                          // height: getProportionateScreenHeight(
                                          //     SizeConfig.screenHeight * 0.07),
                                          width: getProportionateScreenWidth(
                                              SizeConfig.screenWidth * 0.85),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  getProportionateScreenHeight(
                                                      SizeConfig.screenHeight *
                                                          0.02)),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: KBorderColor,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Send   ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          22, 22, 23, 0.8),
                                                      fontFamily: "Raleway",
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              15),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 18,
                                                    color: Color.fromRGBO(
                                                        22, 22, 23, 0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
