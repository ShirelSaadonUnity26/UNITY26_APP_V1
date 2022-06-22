import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';

import 'package:unity26_app_v1/online/online.dart';
import 'package:unity26_app_v1/online/online_data.dart';
import 'package:unity26_app_v1/widget/app_bar.dart';

class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  var user = OnlineData.myUser;

  @override
  void dispose() {
    toController.dispose();
    fromController.dispose();
    super.dispose();
  }

  void updateUserValue(String phone) {
    user.to = phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: 270,
                  child: const Text(
                    "מהן השעות אותן תרצה להגדיר",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            decoration:
                            InputDecoration(labelText: 'משעה'),
                            controller: fromController,
                          ))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for Last Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            decoration:
                            const InputDecoration(labelText: 'עד שעה'),
                            controller: toController,
                          )))
                ],
              ),
               RoundedButton(
                 press: () {
    if (_formKey.currentState!.validate())
    {
    updateUserValue(fromController.text +
    " - " +
    toController.text);
    Navigator.pop(context);
    }

                          },

                          text: 'update',
    )
  ,
              SizedBox(height: size.height * 0.005),
  ],
                      )));


  }
}