import 'dart:io';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/Background.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/components/RoundedInputField.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/screens/date_of_birthday/date_of_birthday_screen.dart';
import 'package:unity26_app_v1/widget/app_bar.dart';


class Body extends StatefulWidget {

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  UserModel ? userModel;

  final lastNameController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  late String idUser;
  late String phone;
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();






  void inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null) {
      idUser = user.uid;
      phone = user.phoneNumber!;
    }
  }

  late SharedPreferences s_prefs;

  String temp = '';

  _saveToShared_Preferences() async {
    s_prefs = await SharedPreferences.getInstance();
    s_prefs.setString("FIRST_NAME", firstNameController.text.toString());
  }

  _showSavedValue() async {
    s_prefs = await SharedPreferences.getInstance();
    setState(() {
      temp = s_prefs.getString("FIRST_NAME").toString();
    });
  }

  _delete_Shared_Preferences() async {
    s_prefs = await SharedPreferences.getInstance();
    s_prefs.remove("FIRST_NAME");
    setState(() {
      temp = " ";
    });
  }

  @override
  Widget build(BuildContext context) {
    inputData();
    Size size = MediaQuery
        .of(context)
        .size;
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
                  press: ()  {
                    if (isValidName(firstNameController.text)
                    && isValidName(lastNameController.text)){
                      _saveToShared_Preferences();
                      updateUserDetails(
                          idUser.toString(), firstNameController.text,
                          lastNameController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DateOfBirthdayScreen();
                          },
                        ),
                      );


                    }
                    else{
                      Alert(context: context,type: AlertType.error,
                                   title: "שגיאה במהלך הרישום",
                                   desc: "השם שהזנת לא תקין")
                                  .show();
                    }


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
}


//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//         appBar: buildAppBar(context),
//         body: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(
//                   width: 330,
//                   child: Text(
//                     "מהו שמך ?",
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
//                       child: SizedBox(
//                           height: 100,
//                           width: 150,
//                           child: TextFormField(
//                             // Handles Form Validation for First Name
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'אנא הזן את שמך הפרטי';
//                               }
//                               return null;
//                             },
//                             cursorColor: Colors.black,
//                             decoration:
//                             const InputDecoration(labelText: 'שם פרטי'),
//                             controller: firstNameController,
//                           ))),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
//                       child: SizedBox(
//                           height: 100,
//                           width: 150,
//                           child: TextFormField(
//                             // Handles Form Validation for Last Name
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'אנא הזן את שם משפחתך';
//                               }
//                               return null;
//                             },
//                             decoration:
//                             const InputDecoration(labelText: 'שם משפחה'),
//                             controller: secondNameController,
//                           )))
//                 ],
//               ),
//               Padding(
//                   padding: EdgeInsets.only(top: 150),
//                   child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: SizedBox(
//                         width: 330,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             stderr.writeln(isValidName(firstNameController.text
//                             ));
//                             // Validate returns true if the form is valid, or false otherwise.
//                             if (_formKey.currentState!.validate() &&
//                                  isValidName(firstNameController.text) && isValidName(secondNameController.text))
//                                      {
//
//                                         _saveToShared_Preferences();
//                                         updateUserDetails(idUser.toString(),firstNameController.text,secondNameController.text);
//                                         Navigator.push(
//                                         context,
//                                           MaterialPageRoute(
//                                               builder: (context) {
//                                                 return const DateOfBirthdayScreen();
//                                         },
//                                       ),
//                                     );
//                                       }
//                             else {
//                               Alert(
//                                   context: context,
//                                   type: AlertType.error,
//                                   title: "שגיאה במהלך הרישום",
//                                   desc: "השם שהזנת לא תקין")
//                                   .show();
//                             }
//                           },
//                           child: const Text(
//                             'Update',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       )))
//             ],
//           ),
//         ));
//   }
//

//
//   bool isNumericUsingRegularExpression(String string) {
//     final numericRegex =
//     RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
//
//     return numericRegex.hasMatch(string);
//   }
//
// }