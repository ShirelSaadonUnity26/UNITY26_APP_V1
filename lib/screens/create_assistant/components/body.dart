import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/components/RoundedInputField.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/screens/create_assistant/components/upload_image.dart';

class Body extends StatefulWidget {


  const Body({Key? key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final professionalController = TextEditingController();
  final categories =
  ["ALL", "MEDICAL", "CAR", "ANIMAL", "LIFESAVER", "THEFTS", "POLICE"];
  FirebaseAuth auth = FirebaseAuth.instance;
  String ? idUser;
  String? phone;
  bool ? flag = false;
  List <String> temp = [];
  bool ? isValidPro;

  void inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null) {
      idUser = user.uid;
      phone = user.phoneNumber!;
    }


    temp.clear();
    // here you write the codes to input the data into firestore
  }

  List<Map> availableHobbies = [
    {"name": "הכל", "isChecked": false, "key": "ALL", "flag": false},
    {
      "name": "מציל חיים",
      "isChecked": false,
      "key": "LIFESAVER",
      "flag": false
    },
    {
      "name": "אלימות",
      "isChecked": false,
      "key": "POLICE",
      "flag": false
    },
    {"name": "רפואי", "isChecked": false, "key": "MEDICAL", "flag": false},
    {"name": "רכב", "isChecked": false, "key": "CAR", "flag": false},
    {"name": "גניבות", "isChecked": false, "key": "THEFTS", "flag": false},
    {"name": "בעלי חיים", "isChecked": false, "key": "ANIMAL", "flag": false},
  ];

  @override
  Widget build(BuildContext context) {
    inputData();
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(

      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                  height: size.height / 7.5,
                  width: 100,
                  child: Image.asset('assets/images/LogoMakr-9JpxYI.png')
              ),
              const Text(
                'תודה על הסכמתך להיות חלק ממערך הסיוע',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  text: 'בכל פעם שמישהו יפעיל קריאה בקרבתך, תקבל התראה לפלאפון אתה תחליט אם להענות לה או לא ',
                  style: DefaultTextStyle
                      .of(context)
                      .style,
                  children: const <TextSpan>[
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              const Text(
                ':מעוניין לקבל התראות במקרים הבאים',
                style: TextStyle(fontSize: 14),
              ),
              // The checkboxes will be here
              Column(
                  children: availableHobbies.map((hobby) {
                    return CheckboxListTile(
                        value: hobby["isChecked"],
                        title: Text(hobby["name"]),
                        onChanged: (newValue) {
                          setState(() {
                            hobby["isChecked"] = newValue;
                            if (hobby["name"] == 'הכל') {
                              for (var hobby in availableHobbies) {
                                hobby["isChecked"] = newValue;
                              }
                            }
                          });
                        });
                  }).toList()),

              // Display the result here
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: availableHobbies.map((hobby) {
                  if (hobby["isChecked"] == true) {
                    String key = hobby["key"];
                    temp = updateList(key);
                    return Card(
                      elevation: 3,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(hobby["key"]),


                      ),
                    );
                  }

                  // categories?.forEach((element) {
                  //   stderr.writeln(element.toString());
                  // });
                  return Container();
                }).toList(),

              ),

              RoundedInputField(
                controller: professionalController,
                hintText: "חובש",
                labelText: "מקצוע",
                icon: const Icon(Icons.person_add, color: Colors.blueGrey),
                onChanged: (value) {

                },
              ),

              RoundedButton(
                  text: " יש לצרף ת.ז/דרכון/רישיון",
                  press: () async {
                    var s = 'ddd';
                   Assistant x =Assistant(category: temp,professional: professionalController.text,descriptionInstrumentation: '', hours:Hours('','')  ,days: []);
                   updateAssistant(idUser.toString(),x);
                   await updateArrayOfCategory(idUser!, x, temp);
                    if(!isValidName(professionalController.text)) {
                    Alert(
                        context: context,
                        type: AlertType.error,
                        title: "שגיאה במהלך הרישום",
                        desc: "המקצוע שהזנת לא תקין")
                        .show();
                    }

                    else{
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) {
                    return UploadImage(assistant: x,);
                  },
                ),
               );
              }

                    }
                  )
              ,

              SizedBox(height: size.height * 0.005),



            ]),


          )
      ),
    );
  }


  List <String> updateList(String key) {
    if ((categories!.contains(key)) && temp!.contains(key)) {
      temp.remove(key);
    }
    else {
      if (categories!.contains(key) && temp!.contains(key) == false) {
        temp.add(key);
      }
    }
    return temp;
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







