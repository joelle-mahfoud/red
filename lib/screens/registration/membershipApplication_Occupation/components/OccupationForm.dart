import 'package:flutter/material.dart';
import 'package:redcircleflutter/components/LabeledCheckbox.dart';
import 'package:redcircleflutter/components/LabledRadio.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/screens/registration/SubmitApplication/SubmitApplication.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';
// import 'package:group_radio_button/group_radio_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class OccupationForm extends StatefulWidget {
  final Membership membership;
  OccupationForm({Key key, this.membership}) : super(key: key);

  @override
  _OccupationFormState createState() => _OccupationFormState();
}

class _OccupationFormState extends State<OccupationForm> {
  // @override
  // void initState() {
  //   _passwordVisible = false;
  // }
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

  bool checkBoxValArts = false;
  bool checkBoxValBeauty = false;
  bool checkBoxValShopping = false;
  // int _Radioval = -1;

  String _isRadioSelected = "";
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
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            LabeledCheckbox(
                                textColor: Colors.white,
                                activeColor: kPrimaryColor,
                                label: "Arts & Culture",
                                value: this.checkBoxValArts,
                                onTap: (bool value) {
                                  setState(() {
                                    this.checkBoxValArts = value;
                                  });
                                }),
                            SizedBox(
                                height: getProportionateScreenHeight(
                                    SizeConfig.screenHeight * 0.01)),
                            LabeledCheckbox(
                                textColor: Colors.white,
                                activeColor: kPrimaryColor,
                                label: "Wellnerss & Beauty",
                                value: this.checkBoxValBeauty,
                                onTap: (bool value) {
                                  setState(() {
                                    this.checkBoxValBeauty = value;
                                  });
                                }),
                            SizedBox(
                                height: getProportionateScreenHeight(
                                    SizeConfig.screenHeight * 0.01)),
                            LabeledCheckbox(
                                textColor: Colors.white,
                                activeColor: kPrimaryColor,
                                label: "Shopping",
                                value: this.checkBoxValShopping,
                                onTap: (bool value) {
                                  setState(() {
                                    this.checkBoxValShopping = value;
                                  });
                                }),
                          ],
                        ),
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
                              groupValue: _isRadioSelected,
                              onChanged: (newValue) {
                                setState(() {
                                  _isRadioSelected = newValue;
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
                              groupValue: _isRadioSelected,
                              onChanged: (newValue) {
                                setState(() {
                                  _isRadioSelected = newValue;
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
                              groupValue: _isRadioSelected,
                              onChanged: (newValue) {
                                setState(() {
                                  _isRadioSelected = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      FormError(errors: errors),
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
                        companyName: companyName,
                        position: position);
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
