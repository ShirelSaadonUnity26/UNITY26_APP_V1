import 'package:flutter/material.dart';



class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double fontSize;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color =Colors.blueGrey,
    this.textColor = Colors.white,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        // ignore: deprecated_member_use
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            color: color,
            onPressed: press,
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: fontSize))),
      ),
    );
  }
}