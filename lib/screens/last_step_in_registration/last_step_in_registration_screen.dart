

import 'package:flutter/material.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/last_step_in_registration/components/body.dart';
class LastStepRegistrationScreen extends StatelessWidget {

  final Assistant assistant;
  const LastStepRegistrationScreen(
      {
        required this.assistant,
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(assistant: assistant,),
    );
  }
}