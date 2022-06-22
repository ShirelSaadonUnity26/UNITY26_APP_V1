import 'package:flutter/material.dart';
import 'package:unity26_app_v1/user_new.dart';
import 'package:unity26_app_v1/user_new_item.dart';


class DetailsList extends StatelessWidget {
  final List<UserNew> items;

  DetailsList({ Key? key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return UserNewItem(item: items[index]);
      },
    );
  }
}