import 'package:flutter/material.dart';
import 'package:redcircleflutter/size_config.dart';

const kPrimaryColor = Color.fromRGBO(
    171, 150, 94, 1); //  Color.fromRGBO(151, 110, 44, 1); //Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const KBackgroundColor = Color.fromRGBO(14, 14, 15, 1);
// const kPrimaryGradientColor = const LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   List: KBorderColor,
//   // List: [Color(0xFFFFA53E), Color(0xFFFF7643)],
//   // colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );
const kSecondaryColor = Colors.white; //Color(0xFF979797);
// const kTextColor = Color.fromRGBO(207, 181, 59, 1); // Color(0xFF757575);
const kTextColor = Color.fromRGBO(
    171, 150, 94, 1); //Color.fromRGBO(151, 110, 44, 1); // Color(0xFF757575);
const KBorderColor = Color.fromRGBO(
    171, 150, 94, 1); //Color.fromRGBO(151, 110, 44, 1); // Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email.";
const String kCheckAlreadyExistEmailError = "USer Already exist.";
const String kPasswordNullError = "Please Enter your password.";
const String kPasswordWeakError = "Weak password.";

const String kConfirmPasswordNullError =
    "Please Enter your confirmed password.";
const String kmatchConfirmPasswordNullError =
    "Please make sure your password macth.";
const String kFirstNameNullError = "Please Enter your first name.";
const String kLastNameNullError = "Please Enter your last name.";
const String kdobNullError = "Please Enter your dob.";
const String kCountryNullError = "Please Enter your country.";
const String kPositionNullError = "Please Enter your Position.";
const String kCompanyNameNullError = "Please Enter your company name.";

const String kInvalidEmailError = "Please Enter Valid Email.";
const String kPassNullError = "Please Enter your password.";
const String kShortPassError = "Password is too short.";
const String kMatchPassError = "Passwords don't match.";
const String kNamelNullError = "Please Enter your name.";
const String kPhoneNumberNullError = "Please Enter your phone number.";
const String kAddressNullError = "Please Enter your address.";

const String kfnamePrefKey = 'fname';
const String kEmailPrefKey = 'email';
const String kPassPrefKey = 'Pass';
const String kclientIdPrefKey = 'clientId';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
