import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallNumberButton extends StatelessWidget {
  final String phoneNumber;

  CallNumberButton({required this.phoneNumber});

  void _callNumber() async {
    String url = "tel://" + this.phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => _callNumber(),
      child: const Text(
        'לחץ לחיוג ',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.green )),
    );
  }
}