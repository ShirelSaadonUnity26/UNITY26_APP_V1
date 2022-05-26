



import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/date_of_birthday/components/body.dart';
import 'package:unity26_app_v1/size_config.dart';
class DateOfBirthdayScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: const Text("birthdday"),
        centerTitle: true,
        backgroundColor: kTextFieldColor,
      ),
    );
  }
}