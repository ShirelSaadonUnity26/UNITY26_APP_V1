


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';

class Body extends StatefulWidget {
  final Assistant assistant;


  const Body({
    required this.assistant

  });

  @override
  _Body createState() => _Body(assistant: assistant);
}


class _Body extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Assistant assistant;
  String ? idUser;
  String description = '';
  _Body({
    required this.assistant,
  });
  void inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null) {
      idUser = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    inputData();
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                  height: size.height / 7.5,
                  width: 100,
                  child: Image.asset('assets/images/LogoMakr-9JpxYI.png')
              ),
              TextFormField(textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: kPrimaryColor,
                    filled: true,
                    hintStyle: TextStyle(fontSize: 11,color: Colors.black),
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'לדוגמא: בלון חמצן',
                    labelText: '?האם יש ברשותך כל דבר חיוני שיוכל לעזור בעת מצוקה',
                    alignLabelWithHint:true,
                    labelStyle: TextStyle(fontSize: 11 )
                ),
                onChanged: (value) {
                  description = value;
                },
                maxLines: 5,
              ),
              const SizedBox(height: 50),
              const Text(
                'סיימנו!!!!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,

                text: TextSpan(
                  text: "כדי שתוכל להוות חלק ממערך הסיוע ותוכל לקבל התראות בזמן אמת ,נבקשך לאשר הרשאת מיקום ברקע תמיד וכן אישור קבלת התראות",
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                  ],
                ),
              ),
              const SizedBox(height: 90),
              RoundedButton(
                  text: "סיום",
                  press: () {
                    assistant.descriptionInstrumentation=description.toString();
                    updateAssistant(idUser.toString()!,assistant);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ),
                    );
                  }),
              SizedBox(height: size.height * 0.005),
            ])));
  }

}