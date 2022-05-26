import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/places_autocomplete/components/routes_widget.dart';

class RoutesWidgetScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  const RoutesWidget(),
      appBar: AppBar(
        title: const Text("SIGN UP"),
        centerTitle: true,
        backgroundColor: kTextFieldColor,
      ),
    );
  }
}