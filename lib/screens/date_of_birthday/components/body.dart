
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' as intl;
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/google_places/places_autocomplete_form_field.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:unity26_app_v1/screens/places_autocomplete/routes_widget_screen.dart';
import  'dart:developer';


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

  @override
  Widget build(BuildContext context) {

    inputData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: const Text('Form widgets'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
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
                                  text: 'UN',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffe46b10)
                                  ),

                                  children: [
                                    TextSpan(
                                      text: 'ITY',
                                      style: TextStyle(color: Colors.black, fontSize: 30),
                                    ),
                                    TextSpan(
                                      text: '26',
                                      style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
                                    ),
                                  ]),
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
                                  update1(idUser.toString(), date.toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return RoutesWidgetScreen();
                                          },
                                        ),
                                       );

                                }),
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
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text('בחר'),
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