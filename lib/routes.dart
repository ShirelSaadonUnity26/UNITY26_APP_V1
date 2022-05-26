import 'package:flutter/widgets.dart';
//import 'package:shop_app/screens/cart/cart_screen.dart';

import 'package:unity26_app_v1/components/date_picker_widget.dart';
import 'package:unity26_app_v1/screens/signUpPart2/age_calculator_screen.dart';

// import 'package:shop_app/screens/home/home_screen.dart';
// import 'package:shop_app/screens/login_success/login_success_screen.dart';
//import 'package:unity26_app_v1/screens/otp/otp_screen.dart';
import 'package:unity26_app_v1/screens/on_boarding/onboard.dart';
// import 'package:shop_app/screens/profile/profile_screen.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
// import 'package:shop_app/screens/splash/splash_screen.dart';
//
// import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => SplashScreen(),
  // SignInScreen.routeName: (context) => SignInScreen(),
  // ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  //SignUpScreen.routeName: (context) => SignUpScreen(),
  DatePickerWidget.routeName: (context) => DatePickerWidget(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  //OtpScreen.routeName: (context) => OtpScreen(),
  //OnBoard.routeName: (context) => OnBoard(),
  // HomeScreen.routeName: (context) => HomeScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  // ProfileScreen.routeName: (context) => ProfileScreen(),
};