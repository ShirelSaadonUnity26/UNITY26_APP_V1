



import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/date_of_birthday/components/body.dart';
class DateOfBirthdayScreen extends StatelessWidget {
  const DateOfBirthdayScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: const Text("המשך רישום"),
        centerTitle: true,
        foregroundColor: kbackground,

      ),
    );
  }
}