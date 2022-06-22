
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/screens/create_assistant/create_assistant.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';

import '../components/RoundedInputField.dart';

// This is the best practice


class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({Key? key}) : super(key: key);

  @override
  _EmergencyContacts createState() => _EmergencyContacts();
}

class _EmergencyContacts extends State<EmergencyContacts> {
  final firstContactNameController = TextEditingController();
  final secondContactNameController = TextEditingController();
  final firstContactPhoneController = TextEditingController();
  final secondContactPhoneController = TextEditingController();

  String?  idUser;
  List <Contact> A=[];


  void inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null){
      idUser=user.uid;
    }
    // here you write the codes to input the data into firestore
  }
  @override
  Widget build(BuildContext context) {
    inputData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
                children: [
                  Text(
                    "הגדרות מערך הסיוע",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.person,
                  //       color: Colors.green,
                  //     ),
                  //     SizedBox(
                  //       width: 8,
                  //     ),
                  //     Text(
                  //       "Account",
                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
                  // Divider(
                  //   height: 15,
                  //   thickness: 2,
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // buildAccountOptionRow(context, "Change password"),
                  // buildAccountOptionRow(context, "Content settings"),
                  // buildAccountOptionRow(context, "Social"),
                  // buildAccountOptionRow(context, "Language"),
                  // buildAccountOptionRow(context, "Privacy and security"),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  Row(
                    children: [
                      Icon(
                        Icons.perm_contact_calendar_sharp,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "אנשי הקשר שלי לחירום",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "איש קשר ראשון",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              RoundedInputField(
                controller: firstContactNameController,
                hintText: "",
                labelText: "שם פרטי",
                icon: const Icon(Icons.contact_phone_sharp, color: Colors.black),
                onChanged: (value) {},
              ),
              RoundedInputField(
                controller: firstContactPhoneController,
                hintText: "",
                labelText: "טלפון",
                icon: const Icon(Icons.phone, color: Colors.black),
                onChanged: (value) {},
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "איש קשר שני",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              RoundedInputField(
                controller: secondContactNameController,
                hintText: "",
                labelText: "שם פרטי",
                icon: const Icon(Icons.contact_phone_sharp, color: Colors.black),
                onChanged: (value) {},
              ),

              RoundedInputField(
                controller: secondContactPhoneController,
                hintText: "",
                labelText: "טלפון",
                icon: const Icon(Icons.phone, color: Colors.black),
                onChanged: (value) {},
              ),
              SizedBox(
                  height: size.height / 2.5,
                  width: 450,
                  child: Image.asset('assets/images/older_woman.png')
              ),
              RoundedButton(
                  text: "סיום ",
                  press: () {
                    bool isValid= isValidContacts(firstContactNameController.text,firstContactPhoneController.text,secondContactNameController.text,secondContactPhoneController.text);

                    if(isValid){


                      //Contact c1=Contact(name: firstContactNameController.text, phone: firstContactPhoneController.text);
                      //Contact c2=Contact(name: secondContactNameController.text, phone: secondContactPhoneController.text);

                      List <Contact> x=[];
                     // x.add(c1);
                      x.add(Contact(name:firstContactNameController.text,phone:firstContactPhoneController.text));
                      x.add(Contact(name:secondContactNameController.text,phone:secondContactPhoneController.text));

                      stderr.writeln(x);


                      updateContact(idUser!, Contact(name:firstContactNameController.text,phone:firstContactPhoneController.text));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  HomeScreen();
                          },
                        ),
                      );
                      showSnackBar(context, 'אנשי הקשר שלך נוספו בהצלחה!');
                    }
                    else{
                      Alert(context: context,type: AlertType.error,
                          title: "שגיאה במהלך הרישום",
                          desc: "הזנת ערכים לא תקינים")
                          .show();
                    }
                  }),

              SizedBox(height: size.height * 0.005),

                ],
            ),
        ),
    );
  }

  bool isValidContacts(String name1, String phone1, String name2, String phone2) {

    if(isValidName(name1)&&isValidName(name2)&&isValidPhone(phone1)&&isValidPhone(phone2)){
      return true;
    }

    return false;
  }
  bool isValidName(String name) {
    final validCharactersEnglish = RegExp(r'^[a-zA-Z _ \-=@,\.;]+$');
    final validCharactersHebrew = RegExp(r'^[\u0590-\u05FF_ \-=@,\.;]+$');

    if(name.length<2 || name.length>30) {
      return false;
    }
    if(name.isEmpty){
      return false;
    }
    if (validCharactersHebrew.hasMatch(name)){
      return true;
    }
    if(validCharactersEnglish.hasMatch(name)){
      return true;
    }
    return false;
  }

  bool isValidPhone(String phone){
    final validPhone = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (validPhone.hasMatch(phone)){
      return true;
    }
    return false;
  }



  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



}