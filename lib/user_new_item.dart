import 'package:flutter/material.dart';

import 'user_new.dart';

class UserNewItem extends StatelessWidget {
  UserNewItem({required this.item});

  final UserNew item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          elevation: 5,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(
                  this.item.name,
                  width: 200,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.lastName,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("id:${this.item.id}"),
                            Text("quantity:${this.item.birthday}"),
                          ],
                        )))
              ]),
        ));
  }
}