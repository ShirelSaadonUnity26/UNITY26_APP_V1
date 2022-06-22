
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/is_assistant/is_assistant_screen.dart';
import 'package:unity26_app_v1/screens/places_autocomplete/routes_widget_screen.dart';


class Body extends StatefulWidget {

  @override
  _Body createState() => _Body();
}


class _Body extends State<Body> {
  late UserBoundary user;
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime date = DateTime.now();
  double maxValue = 0;
  bool? brushedTeeth = false;
  bool enableFeature = false;

  int ageUser(DateTime dateTime){
    int age;
    age= 2022-dateTime.year;
    return age;

  }

  get onClicked => null;
  late String  idUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null){
      idUser=user.uid;
      stderr.writeln(idUser);
    }
  }
  bool isValidAge(DateTime value){
    int age = CURRENT_YEAR-value.year;
    if (age < MIN_AGE_FOR_SIGN_UP || age >MAX_AGE_FOR_SIGN_UP){
      return false;
    }
    return true;



  }

  @override
  Widget build(BuildContext context) {

    inputData();
    Size size = MediaQuery.of(context).size;

    return Scaffold(backgroundColor:kbackground,
      body: Form(key: _formKey,


        child: Scrollbar(

          child: Align(

            alignment: Alignment.center,
            child: Card(color: kbackground,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(70),
                  child: ConstrainedBox(

                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...[
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text: 'פרטים אישיים',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff85b9ee)
                                  ),
                              )
                            ),
                            const SizedBox(
                              height: 170,
                            ),

                            _FormDatePicker(


                              date: date,
                              onChanged: (value) {
                                setState(() {
                                  date = value;
                                });
                              },

                            ),

                            const SizedBox(
                              height: 170,
                            ),
                            RoundedButton(
                                text: "הבא ",
                                press: () {
                                  if(!isValidAge(date)){
                                    Alert(
                                        context: context,
                                        type: AlertType.error,
                                        title: "שגיאה במהלך הרישום",
                                        desc: "תאריך הלידה שהזנת,אינו תקין")
                                        .show();
                                  }
                                  else {
                                    updateDateOfBirth(idUser.toString(), date.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const IsAssistantScreen();

                                          //return RoutesWidgetScreen();
                                        },
                                      ),
                                    );
                                  }
                                }),
                            SizedBox(height: size.height * 0.005),
                      ]
                      ],
                  ),
                ),
            )
          ),
        ),
      ),
    ),

    );
  }
}

bool isValidAge(DateTime value){
  int age = 2022-value.year;
  if (age > 12 && age <85){
    return false;
  }
  return true;



}





class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;



  const _FormDatePicker({
    required this.date,
    required this.onChanged,


  });


  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'תאריך לידה',
              style:
              TextStyle(fontSize: 18,color: kblack)
              // Theme
              //     .of(context)
              //     .textTheme
              //     .bodyText1
            ),

            Text(
              intl.DateFormat.yMd().format(widget.date),
              // style:Theme
              //     .of(context)
              //     .textTheme
              //     .subtitle1,
              style:
              TextStyle(fontSize: 18,color: kblack),

            ),
          ],
        ),
        TextButton(
          child:Text('בחר',style: TextStyle(fontSize: 18 ,color:kblack  )),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);

            save(newDate);
            stderr.writeln(newDate);
          },
        )
      ],
    );
  }


  void save(DateTime newDate) {
    DateTime t = newDate;

  }

  late String idUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null) {
      idUser = user.uid;
      stderr.writeln(idUser);
    }
  }
}