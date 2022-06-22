import 'package:flutter/material.dart';
import 'package:unity26_app_v1/size_config.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: const PhoneAuthPage(),
    );
  }
}