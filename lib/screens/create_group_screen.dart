import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/online/online_data.dart';
import 'package:unity26_app_v1/screens/call_number_button.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  _CreateGroupScreen createState() => _CreateGroupScreen();
}

class _CreateGroupScreen extends State<CreateGroupScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
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
              "קבוצות סיוע אישיות",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.group_add,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "טלפונים של מוקדי סיוע",
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
            buildAccountOptionRow(context, "איחוד והצלה","1221"),
            Divider(),
            buildAccountOptionRow(context, "משטרה","100"),
            Divider(),
            buildAccountOptionRow(context, "מד''א","101"),
            Divider(),
            buildAccountOptionRow(context, "המוקד העירוני","106"),
            buildAccountOptionRow(context, "מכבי אש","102"),
            buildAccountOptionRow(context, "ער''ן","1201"),
            //buildAccountOptionRow1(context, "Content settings"),
            // buildAccountOptionRow(context, "Social"),
            // buildAccountOptionRow(context, "Language"),
            // buildAccountOptionRow(context, "Privacy and security"),
            // SizedBox(
            //   height: 40,
            // ),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.add,
            //       color: Colors.green,
            //     ),
            //     SizedBox(
            //       width: 8,
            //     ),
            //     Text(
            //       "הוסף מספר",
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
            // buildNotificationOptionRow("New for you", true),

            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {




                },

                child: const Text("הוסף מספר",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),


        ]);
  }

  GestureDetector buildAccountOptionRow1(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector buildAccountOptionRow(BuildContext context, String title,String phone) {
    return GestureDetector(
      onTap: () {

        showDialog(
            context: context,
            builder: (BuildContext context) => CallNumberButton(phoneNumber: phone));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.wifi_calling_3,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}