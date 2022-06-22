import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/models/assistantBoundary.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/size_config.dart';
import 'search_fields.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeader createState() => _HomeHeader();

}
  class _HomeHeader extends State<HomeHeader> {

  TextEditingController nameController = TextEditingController();

  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

   autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("FIRST_NAME");
    name = userId.toString();
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });
      return;
    }
    }




  @override
  Widget build(BuildContext context) {
    autoLogIn();
    String temp=greeting();
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenWidth(25)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(80)),
              Text(temp+", " +name,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black,
                    height: 0.5),
              ),
              Text("מהו סוג מקרה החירום שלך?",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5),
              ),
              //Image.asset( "assets/images/sos.png")

            ],
          ),
        ],
      ),
    );
  }

  String greeting() {

    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'בוקר טוב';
    }
    if (hour < 17) {
      return 'צהריים טובים';
    }
    return 'ערב טוב';
  }

}
