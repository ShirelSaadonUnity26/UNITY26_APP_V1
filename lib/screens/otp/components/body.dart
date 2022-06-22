import 'dart:async';

import 'package:unity26_app_v1/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:unity26_app_v1/constants.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key ? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "שלח";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        backgroundColor: kbackground,
        title: const Text(
          "הרשם",
          style: TextStyle(color: Colors.black,fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              textField(),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.black12,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const Text(
                      "הכנס קוד אבטחה",
                      style: TextStyle(fontSize: 16, color: Colors.black)
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              otpField(),
              const SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "הקוד ישלח מחדש בעוד  ",
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      ),
                      TextSpan(
                        text: "00:$start",
                        style: const TextStyle(fontSize: 16, color: Colors.deepOrange),
                      ),
                      const TextSpan(
                        text:"שניות",
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 150,
              ),
              InkWell(
                onTap: () {
                  authClass.signInwithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: const Color(0xff5c7793),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      "אישור",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xfffbe2ae),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: kbackground,
        borderColor: kcolorapp,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.black),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        style: const TextStyle(color: Colors.white, fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "הזן את הטלפון שלך על מנת להתחבר" ,
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+972) ",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
              setState(() {
                start =30;
                wait = true;
                buttonName = "Resend";
              });
              await authClass.verifyPhoneNumber(
                  "+972 ${phoneController.text}", context, setData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}