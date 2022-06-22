import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/profile_page.dart';
import 'package:unity26_app_v1/screens/home/profile_edit/components/body.dart';
class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:ProfilePage(),
      backgroundColor:kPrimaryColor ,
    );
  }
}