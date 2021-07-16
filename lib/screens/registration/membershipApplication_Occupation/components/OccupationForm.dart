import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
// import 'package:redcircleflutter/components/LabeledCheckbox.dart';
import 'package:redcircleflutter/components/LabledRadio.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/models/about.dart';
import 'package:redcircleflutter/screens/registration/SubmitApplication/SubmitApplication.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';
import 'package:http/http.dart' as http;
import 'package:redcircleflutter/size_config.dart';

class OccupationForm extends StatefulWidget {
  final Membership membership;
  OccupationForm({Key key, this.membership}) : super(key: key);

  @override
  _OccupationFormState createState() => _OccupationFormState();
}

class _OccupationFormState extends State<OccupationForm> {
  @override
  void initState() {
    super.initState();
    futureInterested = fetchInterested();
  }
  // String _verticalGroupValue = "Pending";
  // List<String> _status = ["Pending", "Released", "Blocked"];

  final _formKey = GlobalKey<FormState>();
  String companyName;
  String position;
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

  Future<List<Interest>> futureInterested;
  Future<List<Interest>> fetchInterested() async {
    String url = root + "/" + const_get_interest + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<Interest> interests =
            (res['data'] as List).map((i) => Interest.fromJson(i)).toList();
        return interests;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  // int _Radioval = -1;

  List<String> inputs = [];
  void itemChange(bool value, String id) {
    setState(() {
      if (value) {
        if (!inputs.contains(id)) inputs.add(id);
      } else {
        if (inputs.contains(id)) inputs.remove(id);
      }
    });
  }

  String _referenceSelected = "";
  @override
  Widget build(BuildContext context) {
    // final List<GroupItem> radioItems = [
    //   GroupItem(title: 'Radio One'),
    //   GroupItem(title: 'Radio Two'),
    //   GroupItem(title: 'Radio Three'),
    // ];
    // GroupItem _selected;
    return Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.01)),
              Text(
                "STEP 2 OF 3",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.03)),
              Text(
                "YOUR OCCUPATION (optional)",
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildCompanyNameField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildPositionField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.06)),
                      Text(
                        "YOUR INTERESTS (optional)",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      Container(
                        width: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.6),
                        padding: const EdgeInsets.only(right: 20.0, left: 20),
                        child: FutureBuilder(
                            future: futureInterested,
                            builder: (context, projectSnap) {
                              if (projectSnap.connectionState ==
                                  ConnectionState.none) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (projectSnap.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: projectSnap.data.length,
                                  itemBuilder: (context, index) {
                                    Interest inter = projectSnap.data[index];
                                    return new Container(
                                      color: KBackgroundColor,
                                      // padding: new EdgeInsets.all(3.0),
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Theme(
                                              data: ThemeData(
                                                  unselectedWidgetColor:
                                                      Colors.white30),
                                              child: new CheckboxListTile(
                                                  checkColor: kPrimaryColor,
                                                  tileColor: Colors.white,
                                                  activeColor: KBackgroundColor,
                                                  value:
                                                      inputs.contains(inter.id),
                                                  title: new Text(
                                                    inter.title_en,
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14),
                                                  ),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  onChanged: (bool val) {
                                                    itemChange(val, inter.id);
                                                  })),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return Center();
                            }),

                        // ListView(
                        //   shrinkWrap: true,
                        //   children: <Widget>[
                        //     LabeledCheckbox(
                        //         textColor: Colors.white,
                        //         activeColor: kPrimaryColor,
                        //         label: "Arts & Culture",
                        //         value: this.checkBoxValArts,
                        //         onTap: (bool value) {
                        //           setState(() {
                        //             this.checkBoxValArts = value;
                        //           });
                        //         }),
                        //     SizedBox(
                        //         height: getProportionateScreenHeight(
                        //             SizeConfig.screenHeight * 0.01)),
                        //     LabeledCheckbox(
                        //         textColor: Colors.white,
                        //         activeColor: kPrimaryColor,
                        //         label: "Wellnerss & Beauty",
                        //         value: this.checkBoxValBeauty,
                        //         onTap: (bool value) {
                        //           setState(() {
                        //             this.checkBoxValBeauty = value;
                        //           });
                        //         }),
                        //     SizedBox(
                        //         height: getProportionateScreenHeight(
                        //             SizeConfig.screenHeight * 0.01)),
                        //     LabeledCheckbox(
                        //         textColor: Colors.white,
                        //         activeColor: kPrimaryColor,
                        //         label: "Shopping",
                        //         value: this.checkBoxValShopping,
                        //         onTap: (bool value) {
                        //           setState(() {
                        //             this.checkBoxValShopping = value;
                        //           });
                        //         }),
                        //   ],
                        // ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.05)),
                      Text(
                        "HOW DID YOU HEAR ABOUT RED CIRCLE?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      Container(
                        width: getProportionateScreenWidth(
                            SizeConfig.screenWidth * 0.6),
                        padding: const EdgeInsets.only(right: 20.0, left: 20),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            LabeledRadio(
                              activeColor: kPrimaryColor,
                              label: 'Search Engine',
                              textColor: Colors.white,
                              value: 'Search Engine',
                              groupValue: _referenceSelected,
                              onChanged: (newValue) {
                                setState(() {
                                  _referenceSelected = newValue;
                                });
                              },
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(
                                    SizeConfig.screenHeight * 0.01)),
                            LabeledRadio(
                              activeColor: kPrimaryColor,
                              label: 'Referral',
                              textColor: Colors.white,
                              value: 'Referral',
                              groupValue: _referenceSelected,
                              onChanged: (newValue) {
                                setState(() {
                                  _referenceSelected = newValue;
                                });
                              },
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(
                                    SizeConfig.screenHeight * 0.01)),
                            LabeledRadio(
                              activeColor: kPrimaryColor,
                              label: 'Social Media',
                              textColor: Colors.white,
                              value: 'Social Media',
                              groupValue: _referenceSelected,
                              onChanged: (newValue) {
                                setState(() {
                                  _referenceSelected = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      FormError(errors: errors),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    Membership membership = new Membership(
                        fname: widget.membership.fname,
                        lname: widget.membership.lname,
                        email: widget.membership.email,
                        password: widget.membership.password,
                        dob: widget.membership.dob,
                        country: widget.membership.country,
                        packageid: widget.membership.packageid,
                        companyName: companyName,
                        position: position,
                        reference: _referenceSelected,
                        userinterests: getIntersed(inputs));
                    Navigator.pushNamed(context, SubmitApplication.routeName,
                        arguments: membership);
                  }
                },
                child: Container(
                  // height: getProportionateScreenHeight(
                  //     SizeConfig.screenHeight * 0.07),
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
                          text: "NEXT   ",
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
            ],
          ),
        ));
  }

  String getIntersed(List<String> ls) {
    String val = "[";
    ls.forEach((x) {
      val += "{'id':'${x.toString()}'},";
    });
    if (ls.length > 1) val = val.substring(0, val.length - 1);
    val += "]";
    print(val);
    return val;
  }

  TextFormField buildCompanyNameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onSaved: (newValue) => companyName = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kCompanyNameNullError);
        // }
        return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        //   addError(error: kCompanyNameNullError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
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
        hintText: "Company Name",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField buildPositionField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onSaved: (newValue) => position = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kPositionNullError);
        // }
        return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        //   addError(error: kPositionNullError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
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
        hintText: "Position",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
