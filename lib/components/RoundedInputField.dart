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
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        textDirection: TextDirection.rtl,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            hintStyle: const TextStyle(color: kHintColor),
            labelStyle: const TextStyle(

              color: Colors.black,
            ),
            icon: icon,
          )),
      decoration: BoxDecoration(
        color: kTextFieldColor,

        borderRadius: BorderRadius.circular(29),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}