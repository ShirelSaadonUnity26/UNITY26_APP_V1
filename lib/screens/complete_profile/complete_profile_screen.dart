
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/complete_profile/components/body.dart';

class CompleteProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: const Text("SIGN UP"),
        centerTitle: true
      ),
    );
  }
}