import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';
import 'package:unity26_app_v1/screens/home/profile_edit/profile_edit_screen.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: Text('Oflutter.com'),
          //   accountEmail: Text('example@gmail.com'),
          //   currentAccountPicture: CircleAvatar(
          //     child: ClipOval(
          //       child: Image.network(
          //         'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
          //         width: 90,
          //         height: 90,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     image: DecorationImage(
          //       image: NetworkImage(
          //         'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
          //       ),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          //

      DrawerHeader(
      child: Image.asset("assets/images/logo.png"),
      ),
          ListTile(
            enabled: true,
            leading: Icon(Icons.person_outline_rounded),
            title: Text('חשבון'),
            onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileEditScreen(),
                  ),
                );
              },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_sharp),
            title: Text("מערך הסיוע"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('קריאות'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('מידע שימושי'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.menu_book_rounded),
            title: Text('קורסים חינמיים'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.message_sharp),
            title: Text('צור קשר'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite_outline_sharp),
            title: Text('להמליץ לחברים'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('עזרה בשימוש באפליקציה'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text("תנאי שימוש"),
            onTap: () => null,
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('יציאה'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
