import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/Background.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/components/RoundedInputField.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/date_of_birthday/date_of_birthday_screen.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';

class Body extends StatefulWidget {


  @override

  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final firstNameController = TextEditingController();
  final  lastNameController = TextEditingController();
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
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    inputData();
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
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
                    createNewUser(idUser.toString(),phone.toString(),firstNameController.text, lastNameController.text,
                         (user) {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) {
                                 return DateOfBirthdayScreen();
                               },
                             ),
                           );

                });
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