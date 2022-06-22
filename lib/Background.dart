import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            height: size.height * 0.3,
            width: size.width * 0.3,
          ),
          child,
        ],
      ),
    );
  }
}


