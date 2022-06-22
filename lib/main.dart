import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unity26_app_v1/API/user_api.dart';
import 'package:unity26_app_v1/models/user.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity26_app_v1/screens/on_boarding/onboard.dart';
import 'constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'database.dart';
int? isviewed;
String ? idUser;
String ? phone;

String ? name;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  await Firebase.initializeApp();
  runApp(const MyApp());
}
bool inputData() {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  if (user != null) {
    idUser = user.uid;
    phone = user.phoneNumber!;
    stderr.writeln(idUser.toString());
    stderr.writeln(phone.toString());

    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<bool> hasUserLogged() async {
    if(inputData()){
      var x = await UsersApi.getUserSpecific(idUser.toString());
      name=x.lastName.toString();
      stderr.writeln(name);
      print(x.firstName);
      if(x == null){
        return false;
      }
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    hasUserLogged();
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("he", "IL"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("he", "IL") ,// OR Locale('ar', 'AE') OR Other RTL locales,
      debugShowCheckedModeBanner: false,
      title: 'UNITY26',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white,
        textTheme:
        GoogleFonts.poppinsTextTheme().apply(displayColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isviewed!=0 ? OnBoard(): HomeScreen()
    );
  }
}
