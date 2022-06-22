
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/address_complete/components/body.dart';
import 'package:unity26_app_v1/models/user_model.dart';

class AddressComplete extends StatelessWidget {
  final Address address;
  const AddressComplete(
      {
        required this.address,
        });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(address: address,),
      appBar: AppBar(
        title: const Text("SIGN UP"),
        centerTitle: true,
        backgroundColor: kTextFieldColor,
      ),
    );
  }
}