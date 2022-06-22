

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/Background.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/components/RoundedInputField.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/date_of_birthday/date_of_birthday_screen.dart';

class Body extends StatefulWidget {

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  UserBoundary ? userBoundary;
  final firstNameController = TextEditingController();
  final  lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final hmoController= TextEditingController();
  final importantDetailsController= TextEditingController();
  final emailController= TextEditingController();
  final streetController = TextEditingController();
  final  houseNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  final  cityController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  late String  idUser;
  late String phone;



  void inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null){
      idUser=user.uid;
      phone=user.phoneNumber!;
      print(user.phoneNumber!);
      print(user.uid);
    }

  }

  @override
  Widget build(BuildContext context) {
    inputData();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: size.height / 2.5,
                width: 300,
                child: Background(child: Container()),
              ),
              RoundedInputField(
                controller: firstNameController,
                hintText: "שניר",
                labelText: "שם פרטי",
                icon: const Icon(Icons.person, color: Colors.black),
                onChanged: (value) {},
              ),
              RoundedInputField(
                controller: lastNameController,
                hintText: "יצחק",
                labelText: "שם משפחה",
                icon: const Icon(Icons.person, color: Colors.black),
                onChanged: (value) {},
              ),

              RoundedButton(
                  text: "הבא ",
                  press: () {
                    updateUserDetails(idUser.toString(),firstNameController.text,lastNameController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DateOfBirthdayScreen();
                        },
                      ),
                    );
                  }),
              SizedBox(height: size.height * 0.005),
            ])));
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }








}