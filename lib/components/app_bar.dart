import 'package:flutter/material.dart';
import 'package:unity26_app_v1/constants.dart';


AppBar buildAppBar(BuildContext context,
    {bool isTransparent = false, required String title}) {
  return AppBar(
    backgroundColor: isTransparent ? Colors.transparent : Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.menu,
        textDirection: TextDirection.rtl,
        color: kIconColor,
      ),
      onPressed: () {},
    ),
    title: ! isTransparent
        ? Text(
            isTransparent ? "" : title,
            style: const TextStyle(color: kTextColor),
          )
        : null,
    centerTitle: true,

  );
}
