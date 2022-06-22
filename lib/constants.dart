import 'package:flutter/material.dart';
import 'package:unity26_app_v1/size_config.dart';

const kPrimaryColor = Color(0xF8F8F8FF);
const kTextColor1 = Color(0xFFF8F8F8);
const kIconColor = Color(0xFF5E5E5E);

const kDefaultPadding = 20.0;

final kDefualtShadow = BoxShadow(
  offset: const Offset(5, 5),
  blurRadius: 10,
  color: const Color(0xFFE9E9E9).withOpacity(0.56),
);
const kPrimaryColor1 = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
Color kSecondaryColor = const Color(0xFF979797);
const kTextColor = Color(0xFF6C7EA3);
Color kblue = const Color(0x6C0F47CC);
Color kwhite = const Color(0xFFFFFFFF);
const kbackground = Color(0xFFF8F8F8);
const kcolorapp = Color(0xFF5C7793);
Color kblack = const Color(0xFF000000);
Color kbrown300 = const Color(0xFF8D6E63);
Color kblue1 = const Color(0x221D5DF6);
Color kgrey = const Color(0xFFC0C0C0);
Color kgrey1 = const Color(0xFFD9A9A9);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const String logo= "logomakr.com/app/4XKXCI";
const defaultDuration = Duration(milliseconds: 250);
String HOME_SCREEN='/HomeScreen',IMAGE_SPLASH='/ImageSplashScreen',VIDEO_SPALSH='/VideoSplashScreen',
    ANIMATED_SPALSH='/AnimatedSplashScreen';
// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
//////////////////////////////////////////////////////////////
const String splash1_title = "ברוכים הבאים";
const String splash1_des = "מהיום ניתן לקבל סיוע בכל מקרה חירום ";
const kHintColor = Color(0xB54B4B4B);
const kTextFieldColor = Color(0x970066FF);
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
    borderSide: const BorderSide(color: kTextColor),
  );

}
const CURRENT_YEAR=2022;
const MIN_AGE_FOR_SIGN_UP=12;
const MAX_AGE_FOR_SIGN_UP=88;
const USER_COLLECTION = "users";

const Map<String, String> kJsonHeaders = {
  'Content-Type': 'application/json',
  'accept': 'application/json'
};