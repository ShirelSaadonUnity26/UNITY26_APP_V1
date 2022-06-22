
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/components/app_bar.dart';
import 'package:unity26_app_v1/components/custom_bottom_nav_bar.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/user.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/home/components/NanBar.dart';
import 'package:unity26_app_v1/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Body(),
      bottomNavigationBar: const CustomBottonNavBar(),
      backgroundColor:kPrimaryColor ,
    );
  }
}