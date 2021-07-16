import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/functions/login.dart';
import 'package:redcircleflutter/helper/keyboard.dart';
import 'package:redcircleflutter/size_config.dart';

class CashCreditRorm extends StatefulWidget {
  @override
  _CashCreditRormState createState() => _CashCreditRormState();
}

class _CashCreditRormState extends State<CashCreditRorm> {
  final _formKey = GlobalKey<FormState>();

  String amount;
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

  TextFormField buildAmountFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
      ],
      onSaved: (newValue) => amount = newValue,
      onChanged: (value) {
        // amount = double.parse(value),
        if (value.isNotEmpty) {
          removeError(error: kAmountNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAmountNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
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
        hintText: "Enter Amount",
        suffixIcon: Text(
          "(€)",
          style: TextStyle(color: Colors.white),
        ),
        suffixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.24),
                  left: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.24)),
              child: buildAmountFormField(),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        errors.clear();
                      });
                      KeyboardUtil.hideKeyboard(context);

                      bool shouldUpdate = await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'Confirmation',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                elevation: 100,
                                backgroundColor: KBackgroundColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: kPrimaryColor.withOpacity(0.8)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text(
                                      'No',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      addWallet(1, "0", amount).then((value) {
                                        if (value != null)
                                          Navigator.pop(context, true);
                                        else {
                                          Navigator.pop(context, false);
                                        }
                                      }),
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ),
                                ],
                              ));
                      if (shouldUpdate) {}
                    }
                  },
                  child: Container(
                    height: getProportionateScreenWidth(50),
                    width: getProportionateScreenWidth(
                        SizeConfig.screenWidth * 0.3),
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(
                            SizeConfig.screenHeight * 0.02)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(5.0)),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          //
                          WidgetSpan(
                            child: Image(
                              height: 20,
                              width: 26,
                              image: AssetImage('assets/images/pay.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          TextSpan(
                            text: "Wallet",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Raleway",
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "or",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () => {
                    // gotoComfirmbillingCycle(),
                  },
                  child: Container(
                    height: getProportionateScreenWidth(50),
                    width: getProportionateScreenWidth(
                        SizeConfig.screenWidth * 0.3),
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(
                            SizeConfig.screenHeight * 0.02)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                          color: Color.fromRGBO(171, 150, 94, 1), width: 0.8),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.call_to_action_rounded,
                              size: 18,
                              color: kPrimaryColor,
                            ),
                          ),
                          TextSpan(
                            text: " CARD",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: "Raleway",
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
