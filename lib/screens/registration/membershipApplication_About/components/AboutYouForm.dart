import 'dart:convert';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/form_error.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/screens/registration/membership.dart';
import 'package:redcircleflutter/screens/registration/membershipApplication_Occupation/membership_application_occupation.dart';
import 'package:http/http.dart' as http;
import 'package:redcircleflutter/size_config.dart';

bool firstStart = true;

class AboutYouForm extends StatefulWidget {
  @override
  _AboutYouFormState createState() => _AboutYouFormState();
}

class Country {
  final String id;
  final String name;
  // String get name => "Book$id";

  Country({this.id, this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["id"],
      name: json["country_name"],
    );
  }
}

class _AboutYouFormState extends State<AboutYouForm> {
  List<Country> data = []; //edited line

  // Future<String> getSWData() async {
  //   final response =
  //       await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  //   if (response.statusCode == 200) {
  //     return (json.decode(serviceDummyData) as List)
  //         .map((i) => Service.fromJson(i))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

  getCountries() async {
    String url = root + "/" + const_getCountries + "?token=" + token;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");
    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);

        List<Country> cntrs1 =
            (res['data'] as List).map((i) => Country.fromJson(i)).toList();

        setState(() {
          data = cntrs1;
          // data =
          //     List<Country>.generate(10, (id) => Country.fromJson(res['data']));
        });
        return "Sucess";
      } else {
        print(" ${res['message']}");
        return "res['message']";
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  final _formKey = GlobalKey<FormState>();
  String fname;
  String lname;
  String email;
  String password;
  String confirmPassword;
  String dob;
  String country;

  bool remember = false;

  final List<String> errors = [];
  bool addCountry() {
    if (firstStart == false && country == "-1") {
      addError(error: kCountryNullError);
      return false;
    }
    return true;
    // if (selectedValue == "" || selectedValue == null) {
    //   addError(error: kCountryNullError);
    // }
  }

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

  String selectedValue = "Lebanon";
  @override
  Widget build(BuildContext context) {
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
                "STEP 1 OF 3",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.03)),
              Text(
                "ABOUT YOU",
                style: TextStyle(color: Colors.white),
              ),

              // Container(
              //     height: 10, child: Expanded(flex: 1, child: Text("data"))),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildFirstFormField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildLastNameFormField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildEmailFormField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildPassFormField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      buildComdirmPassFormField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      // buildPasswordFormField(),
                      // SizedBox(
                      //     height: getProportionateScreenWidth(
                      //         SizeConfig.screenHeight * 0.02)),

                      buildbBirthFormField(),
                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),

                      // SearchableDropdown.single(
                      //   menuBackgroundColor: KBackgroundColor,
                      //   style: TextStyle(color: Colors.yellow),
                      //   items: data.map((item) {
                      //     return new DropdownMenuItem(
                      //       child: new Text(
                      //         item.name,
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //       value: item.name,
                      //     );
                      //   }).toList(),
                      //   underline: Container(
                      //     height: 1.0,
                      //     decoration: BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //                 color: (country == "-1")
                      //                     ? Colors.red
                      //                     : Colors.white.withOpacity(0.3),
                      //                 width: 1.0))),
                      //   ),
                      //   validator: (selectedItemsForValidator) {
                      //     if (selectedItemsForValidator == null) return null;
                      //     if (selectedItemsForValidator.length == 0) {
                      //       addError(error: kCountryNullError);
                      //       return "";
                      //     }
                      //     return null;
                      //   },
                      //   closeButton: (selectedItemsClose) {
                      //     return Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: <Widget>[
                      //         InkWell(
                      //           child: Text(
                      //             "Close",
                      //             style: TextStyle(fontSize: 20),
                      //           ),
                      //           onTap: () => Navigator.pop(context),
                      //         )
                      //       ],
                      //     );
                      //   },
                      //   value: selectedValue,
                      //   hint: Text("Select Country",
                      //       style: TextStyle(
                      //           color: Colors.white.withOpacity(0.8))),
                      //   searchHint: new Text(
                      //     'Select Country',
                      //     style: new TextStyle(fontSize: 15),
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectedValue = value;
                      //     });
                      //     country = data
                      //         .firstWhere((cn) => cn.name == selectedValue)
                      //         .id;
                      //   },
                      //   isExpanded: true,
                      //   displayItem: (item, selected) {
                      //     return (Row(children: [
                      //       selected
                      //           ? Icon(
                      //               Icons.radio_button_checked,
                      //               color: Colors.grey,
                      //             )
                      //           : Icon(
                      //               Icons.radio_button_unchecked,
                      //               color: Colors.grey,
                      //             ),
                      //       SizedBox(width: 7),
                      //       Expanded(
                      //         child: item,
                      //       ),
                      //     ]));
                      //   },
                      // ),

                      buildCountryOfResidenceFormField(),

                      SizedBox(
                          height: getProportionateScreenHeight(
                              SizeConfig.screenHeight * 0.02)),
                      FormError(errors: errors),

                      InkWell(
                        onTap: () async {
                          if (country == null) country = "-1";
                          firstLoad = false;

                          firstStart = false;
                          String cntry = data
                              .firstWhere((cn) => cn.name == selectedValue)
                              .id;
                          setState(() {
                            country = cntry;
                          });
                          if (!addCountry()) {
                            return;
                          }

                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (!await checkAlreadyExistEmail(email)) {
                              addError(error: kCheckAlreadyExistEmailError);
                              return;
                            }
                            setState(() {
                              errors.clear();
                            });
                            KeyboardUtil.hideKeyboard(context);

                            Navigator.pushNamed(context,
                                MembershipApplicationOccupation.routeName,
                                arguments: Membership(
                                    fname: fname,
                                    lname: lname,
                                    email: email,
                                    password: password,
                                    dob: dob,
                                    country: country));
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
                ),
              ),
            ],
          ),
        ));
  }

  TextFormField buildFirstFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.name,
      onSaved: (newValue) => fname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFirstNameNullError);
          return "";
        }
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
        hintText: "First Name",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLastNameNullError);
          return "";
        }
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
        hintText: "Last Name",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
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
        hintText: "Email Address",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<bool> ischeckAlreadyExistEmail(String email) async {
    bool isLoggedIn = await checkAlreadyExistEmail(email);
    return isLoggedIn;
  }

  static Future<bool> checkAlreadyExistEmail(String email) async {
    //http://192.168.0.112:8383/redcircle/web/api/checkmail.php?token=rb115oc-Rcas|Kredcircleu&email=jalal123@hotmail.com
    dynamic response;
    print(root + "/" + const_checkmail + "?token=" + token + "&email=" + email);
    try {
      response = await http.post(
        Uri.parse(root +
            "/" +
            const_checkmail +
            "?token=" +
            token +
            "&email=" +
            email),
        headers: {"Accept": "application/json"},
      );
    } catch (e) {
      print(e);
    }
    print(" ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['result'] == 1)
        return true;
      else
        return false;
    } else
      return false;
  }

  bool _passwordVisible = false;
  TextFormField buildPassFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_passwordVisible,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty) {
          removeError(error: kPasswordWeakError);
          removeError(error: kPasswordNullError);
          removeError(error: kmatchConfirmPasswordNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPasswordNullError);
          return "";
        }
        if (value.length < 6) {
          addError(error: kPasswordWeakError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: EdgeInsets.all(3),
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
        hintText: "Choose Password",
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey, // Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildComdirmPassFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kConfirmPasswordNullError);
          removeError(error: kmatchConfirmPasswordNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kConfirmPasswordNullError);
          return "";
        }
        if (value != password) {
          addError(error: kmatchConfirmPasswordNullError);
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
        hintText: "Confirm Password",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  TextEditingController dateCtl = TextEditingController();
  TextFormField buildbBirthFormField() {
    return TextFormField(
      controller: dateCtl,
      onTap: () async {
        DateTime date = DateTime(1900);
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
          context: context,
          initialDate: DateTime(DateTime.now().year - 10),
          firstDate: DateTime(1900),
          lastDate: DateTime(DateTime.now().year),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                    primary: kPrimaryColor), //const  Color(kPrimaryColor)
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child,
            );
          },
        );

        dateCtl.text = DateFormat('yyyy-MM-dd').format(date);
        removeError(error: kdobNullError);
      },
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.datetime,
      onSaved: (newValue) => dob = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kdobNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kdobNullError);
          return "";
        }
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
        hintText: "Date Of Birth",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  bool firstLoad = true;
  Widget buildCountryOfResidenceFormField() {
    return Theme(
      data: ThemeData.dark().copyWith(
        accentColor: kPrimaryColor,
      ),
      child: SearchableDropdown.single(
        menuBackgroundColor: KBackgroundColor,
        style: TextStyle(color: Colors.yellow),
        items: data.map((item) {
          return new DropdownMenuItem(
            child: new Text(
              item.name,
              style: TextStyle(color: Colors.white),
            ),
            value: item.name,
          );
        }).toList(),
        underline: Container(
          height: 1.0,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: (country == "-1")
                          ? Colors.red
                          : Colors.white.withOpacity(0.3),
                      width: 1.0))),
        ),
        validator: (selectedItemsForValidator) {
          if (firstLoad) return "";
          if (selectedItemsForValidator == null ||
              selectedItemsForValidator.length == 0) {
            // addError(error: kCountryNullError);
            return "";
          }
          return null;
        },
        closeButton: (selectedItemsClose) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                child: Text(
                  "Close",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () => Navigator.pop(context),
              )
            ],
          );
        },
        value: selectedValue,
        hint: Text("Select Country",
            style: TextStyle(color: Colors.white.withOpacity(0.8))),
        searchHint: new Text(
          'Select Country',
          style: new TextStyle(fontSize: 15),
        ),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          if (value == null) {
            setState(() {
              country = "-1";
            });
            return null;
          } else {
            removeError(error: kCountryNullError);
            String cntry = data.firstWhere((cn) => cn.name == selectedValue).id;
            setState(() {
              country = cntry;
            });
            return null;
          }
        },
        isExpanded: true,
        displayItem: (item, selected) {
          return (Row(children: [
            selected
                ? Icon(
                    Icons.radio_button_checked,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                  ),
            SizedBox(width: 7),
            Expanded(
              child: item,
            ),
          ]));
        },
      ),
    );

    // return DropdownButtonFormField(
    //     style: TextStyle(color: Colors.white),
    //     dropdownColor: Colors.black,
    //     onSaved: (newValue) => country = newValue,
    //     onChanged: (value) {
    //       if (value.isNotEmpty) {
    //         removeError(error: kCountryNullError);
    //       }
    //       return null;
    //     },
    //     validator: (value) {
    //       if (value.isEmpty) {
    //         addError(error: kCountryNullError);
    //         return "";
    //       }
    //       return null;
    //     },
    //     decoration: InputDecoration(
    //       contentPadding: EdgeInsets.all(5),
    //       enabledBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
    //       ),
    //       focusedBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(color: KBorderColor),
    //       ),
    //       border: UnderlineInputBorder(
    //         borderSide: BorderSide(color: Colors.yellow.withOpacity(0.3)),
    //       ),
    //       errorBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(color: Colors.red.withOpacity(0.8)),
    //       ),
    //       focusedErrorBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(color: Colors.red),
    //       ),
    //       hintText: "Country Of Residence",
    //       hintStyle: TextStyle(color: Colors.white),
    //     ),
    //     items: data.map((item) {
    //       //  return new DropdownMenuItem(
    //       //    child: new Text(item['country_name']),
    //       //   value: item['id'].toString(),
    //       //  );
    //     }).toList());

    // return TextFormField(
    //   style: TextStyle(color: Colors.white),
    //   keyboardType: TextInputType.text,
    //   onSaved: (newValue) => country = newValue,
    //   onChanged: (value) {
    //     if (value.isNotEmpty) {
    //       removeError(error: kCountryNullError);
    //     }
    //     return null;
    //   },
    //   validator: (value) {
    //     if (value.isEmpty) {
    //       addError(error: kCountryNullError);
    //       return "";
    //     }
    //     return null;
    //   },
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.all(5),
    //     enabledBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
    //     ),
    //     focusedBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: KBorderColor),
    //     ),
    //     border: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Colors.yellow.withOpacity(0.3)),
    //     ),
    //     errorBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Colors.red.withOpacity(0.8)),
    //     ),
    //     focusedErrorBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(color: Colors.red),
    //     ),
    //     hintText: "Country Of Residence",
    //     hintStyle: TextStyle(color: Colors.white),
    //   ),
    // );
  }
}
