import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/models/Contactform.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final List<String> errors = [];

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
  String fullname;
  TextFormField buildFullNameFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: fullnameInitialValue,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fullname = newValue,
      onChanged: (value) {
        fullname = value;
        if (value.isNotEmpty) {
          removeError(error: kFullNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFullNameNullError);
          return "";
        }
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
        hintText: "Full Name*",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  String email;
  TextFormField buildEmailFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      initialValue: emailInitialValue,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
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
        hintText: "E-mail*",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  String phonenumber;
  TextFormField buildPhoneFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phonenumber = newValue,
      onChanged: (value) {
        fullname = value;
        if (value.isNotEmpty) {
          removeError(error: kFullNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFullNameNullError);
          return "";
        }
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
        hintText: "Phone Number",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  String message;
  TextFormField buildMessageFormField() {
    return TextFormField(
      minLines: 3,
      maxLines: 10,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (newValue) => message = newValue,
      onChanged: (value) {
        message = value;
        if (value.isNotEmpty) {
          removeError(error: kMessageNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kMessageNullError);
          return "";
        }
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
        hintText: "Message*",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  String toEmail;
  Future<Contactform> futureContactform;
  Future<Contactform> fetchContactform() async {
    //{{url}}/get_contactform_email.php?token={{token}}
    String url = root + "/" + const_get_contactform_email + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        Contactform contactform = Contactform.fromJson(res);
        // setState(() {
        //   toEmail = contactform.contactFormEmail;
        // });
        return contactform;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
  }

  String fullnameInitialValue = '';
  String emailInitialValue = '';
  static SharedPreferences _pref;
  Future _getfName() async {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      fullnameInitialValue = _pref.getString(kfnamePrefKey);
      emailInitialValue = _pref.getString(kEmailPrefKey);
    });
  }

  @override
  void initState() {
    futureContactform = fetchContactform();
    _getfName();
    super.initState();
  }

  Future<bool> sendEmail(
      String from, String body, String fullname, String phone) async {
    //send_mail.php?token=rb115oc-Rcas|Kredcircleu&email=jalal@hotmail.com&phone=828822&name=jala&comment=hello
    dynamic response;
    try {
      response = await http.post(
        Uri.parse(root +
            "/" +
            const_sendEmail +
            "?token=" +
            token +
            "&email=" +
            from +
            "&phone=" +
            phone +
            "&name=" +
            fullname +
            "&comment=" +
            body),
        headers: {"Accept": "application/json"},
      );
    } catch (e) {
      print(e);
    }
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

  List<Widget> _generateEmails(List<Email> myObjects) {
    if (myObjects == null) return [];
    var list = myObjects.map<List<Widget>>(
      (data) {
        var widgetList = <Widget>[];
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: data.titleEn + "  ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                children: [
                  TextSpan(
                      text: data.email,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                ],
              ),
            ),
          ],
        ));
        return widgetList;
      },
    ).toList();
    var flat = list.expand((i) => i).toList();
    return flat;
  }

  List<Widget> _generatePhones(List<Phone> myObjects) {
    if (myObjects == null) return [];
    var list = myObjects.map<List<Widget>>(
      (data) {
        var widgetList = <Widget>[];
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: data.titleEn + "  ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                children: [
                  TextSpan(
                      text: data.phone,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                ],
              ),
            ),
          ],
        ));
        return widgetList;
      },
    ).toList();
    var flat = list.expand((i) => i).toList();
    return flat;
  }

  List<Widget> _generateAddresses(List<Addresse> myObjects) {
    if (myObjects == null) return [];
    var list = myObjects.map<List<Widget>>(
      (data) {
        var widgetList = <Widget>[];
        widgetList.add(Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.titleEn,
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data.addressEn,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              // textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18.0),
              maxLines: 2,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
        return widgetList;
      },
    ).toList();
    var flat = list.expand((i) => i).toList();
    return flat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: KBackgroundColor,
        centerTitle: true,
        title: Text(
          "Contact Us",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Form(
                        key: _formKey,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      SizeConfig.screenHeight * 0.01)),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildFullNameFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildPhoneFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildEmailFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      buildMessageFormField(),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.02)),
                                      FormError(errors: errors),
                                      // AbsorbPointer(
                                      //   absorbing: (toEmail == null),
                                      //   child:
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
                                                                    sendEmail(
                                                                            email,
                                                                            message,
                                                                            fullname,
                                                                            phonenumber)
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
                                      // ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              SizeConfig.screenHeight * 0.05)),
                                      FutureBuilder(
                                        builder: (context, projectSnap) {
                                          if (projectSnap.connectionState ==
                                                  ConnectionState.none &&
                                              projectSnap.hasData == null) {
                                            return Center(
                                                child:
                                                    new CircularProgressIndicator());
                                          } else if (projectSnap.hasData) {
                                            Contactform val = projectSnap.data;
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Column(
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        val.contactPhones !=
                                                            null,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.call,
                                                            size: 40.0,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          SizedBox(
                                                              width: getProportionateScreenWidth(
                                                                  SizeConfig
                                                                          .screenWidth *
                                                                      0.05)),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Call Us",
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    fontSize:
                                                                        21,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: getProportionateScreenHeight(
                                                                    SizeConfig
                                                                            .screenHeight *
                                                                        0.01),
                                                              ),
                                                              Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children:
                                                                      _generatePhones(
                                                                          val.contactPhones)),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            SizeConfig
                                                                    .screenHeight *
                                                                0.03),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        val.contactEmails !=
                                                            null,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.email,
                                                            size: 40.0,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          SizedBox(
                                                              width: getProportionateScreenWidth(
                                                                  SizeConfig
                                                                          .screenWidth *
                                                                      0.05)),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Message",
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    fontSize:
                                                                        21,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: getProportionateScreenHeight(
                                                                    SizeConfig
                                                                            .screenHeight *
                                                                        0.01),
                                                              ),
                                                              Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children:
                                                                      _generateEmails(
                                                                          val.contactEmails)),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            SizeConfig
                                                                    .screenHeight *
                                                                0.03),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        val.contactAddresses !=
                                                            null,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            size: 40.0,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          SizedBox(
                                                              width: getProportionateScreenWidth(
                                                                  SizeConfig
                                                                          .screenWidth *
                                                                      0.05)),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Our Location",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      fontSize:
                                                                          21,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: getProportionateScreenHeight(
                                                                      SizeConfig
                                                                              .screenHeight *
                                                                          0.01),
                                                                ),
                                                                Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children:
                                                                        _generateAddresses(
                                                                            val.contactAddresses)),
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ],
                                              ),

                                              // child: Column(
                                              //   children: [
                                              //     Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment.start,
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment
                                              //               .start,
                                              //       children: [
                                              //         Icon(
                                              //           Icons.email,
                                              //           size: 30.0,
                                              //           color: kPrimaryColor,
                                              //         ),
                                              //         SizedBox(
                                              //           width: getProportionateScreenWidth(
                                              //               SizeConfig
                                              //                       .screenWidth *
                                              //                   0.05),
                                              //         ),
                                              //         // SizedBox(wi)(width: getProportionateScreenWidth(SizeConfig.screenHeight * 0.05)),                                              )),
                                              //         Column(
                                              //           children: <Widget>[
                                              //             Text(
                                              //               "Title:",
                                              //               style: TextStyle(
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .bold),
                                              //             ),
                                              //             Text(val
                                              //                 .contactEmails[0]
                                              //                 .email),
                                              //           ],
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment.start,
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment
                                              //               .start,
                                              //       children: [
                                              //         Icon(
                                              //           Icons.add_circle_sharp,
                                              //           size: 30.0,
                                              //           color: kPrimaryColor,
                                              //         ),
                                              //         SizedBox(
                                              //           width: getProportionateScreenWidth(
                                              //               SizeConfig
                                              //                       .screenWidth *
                                              //                   0.05),
                                              //         ),
                                              //         // SizedBox(wi)(width: getProportionateScreenWidth(SizeConfig.screenHeight * 0.05)),                                              )),
                                              //         Column(
                                              //           crossAxisAlignment:
                                              //               CrossAxisAlignment
                                              //                   .start,
                                              //           children: [
                                              //             Text(
                                              //               val
                                              //                   .contactAddresses[
                                              //                       0]
                                              //                   .titleEn,
                                              //               style: TextStyle(
                                              //                   fontSize: 20),
                                              //             ),
                                              //             Text(val
                                              //                 .contactAddresses[
                                              //                     0]
                                              //                 .addressEn),
                                              //             Text(
                                              //                 val
                                              //                     .contactAddresses[
                                              //                         0]
                                              //                     .titleEn,
                                              //                 style: TextStyle(
                                              //                     fontSize:
                                              //                         20)),
                                              //             Text(val
                                              //                 .contactAddresses[
                                              //                     0]
                                              //                 .addressEn),
                                              //           ],
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                            );
                                          }
                                          return Center();
                                        },
                                        future: futureContactform,
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
