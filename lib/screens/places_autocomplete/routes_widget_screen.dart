import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/places_autocomplete/components/routes_widget.dart';

class RoutesWidgetScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomSearchScaffold(),
      appBar: AppBar(
        title: const Text("המשך רישום"),
        centerTitle: true,
        backgroundColor: kTextFieldColor,
      ),

    );
  }
}