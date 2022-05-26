import 'package:flutter/material.dart';
import 'package:unity26_app_v1/components/app_bar.dart';
import 'package:unity26_app_v1/components/custom_bottom_nav_bar.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context, isTransparent: true, title: ''),
      body: Body(),
      bottomNavigationBar: CustomBottonNavBar(),
    );
  }
}