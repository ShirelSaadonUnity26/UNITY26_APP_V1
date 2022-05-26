import 'package:flutter/material.dart';
import 'package:unity26_app_v1/components/app_bar.dart';
import 'package:unity26_app_v1/components/custom_bottom_nav_bar.dart';
import 'package:unity26_app_v1/screens/event/components/body.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "New Events"),
      body: Body(),
      bottomNavigationBar: CustomBottonNavBar(),
    );
  }
}
