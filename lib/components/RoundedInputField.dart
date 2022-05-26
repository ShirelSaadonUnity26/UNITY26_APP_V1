import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';



class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Icon icon;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: this.icon,
            hintText: this.hintText,
            labelText: this.labelText,
            hintStyle: TextStyle(color: kHintColor),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          )),
      decoration: BoxDecoration(
        color: kTextFieldColor,
        borderRadius: BorderRadius.circular(29),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}