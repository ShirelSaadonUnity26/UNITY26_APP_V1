import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity26_app_v1/Background.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/components/RoundedInputField.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:http/http.dart' as http;
import 'package:unity26_app_v1/screens/emergency_contacts.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';
Future<Album> fetchAlbum(String idUser) async {

  stderr.writeln(idUser);
  final response = await http
      .get(Uri.parse('http://192.168.1.101:8080/users/getUser/$idUser'));

  if (response.statusCode == 200) {
    stderr.writeln(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
Future<Album> updateAlbum(String idUser,String firstName,String lastName,String birthday,String hmo,String info,String email) async {
  final response = await http.patch(
    Uri.parse('http://192.168.1.101:8080/users/updateUser1/$idUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstName,
      'lastName':lastName,
      'birthday':birthday,
      'hmo':hmo,
      'info':info,
      'email':email,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

class Album {

  final String idUser;
  final String phone;
  final String firstName;
  final String lastName;
  final String birthday;
  final String email;
  final String info;
  final String hmo;
  final List<HelpCenter> helpCenter;
  final List<Contact> contact;
  final Assistant assistant;

  final int v;


  const Album({
    required this.idUser,
    required this.phone,
    required this.email,
    required this.info,
    required this.hmo,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.helpCenter,
    required this.contact,
    required this.assistant,
    required this.v,

  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        idUser:json['_id'] ,
        phone: json['phone'],
        email: json['email'] ?? '',
        hmo: json['hmo'] ?? '' ,
        info: json['info']  ?? '',
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthday: json['birthday'],
        v: json['__v']as int,
        assistant: Assistant.fromJson(json['assistant'] ?? ''),
        helpCenter:List<HelpCenter>.from(
            json["helpCenter"].map((x) => HelpCenter.fromJson(x))),
        contact: List<Contact>.from(
          json["contacts"].map((x) => Contact.fromJson(x))),



    );
  }
}
class Contact {
  Contact({
    required this.name,
    required this.phone,
  });

  final String name;
  final String phone;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json["name"] ?? '',
    phone: json["phone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}
class HelpCenter {
  HelpCenter({
    required this.helpCenterName,
    required this.helpCenterPhone,
  });

  final String helpCenterName;
  final String helpCenterPhone;

  factory HelpCenter.fromJson(Map<String, dynamic> json) => HelpCenter(
    helpCenterName: json["helpCenterName"] ?? '',
    helpCenterPhone: json["helpCenterPhone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "helpCenterName": helpCenterName,
    "helpCenterPhone": helpCenterPhone,
  };
}
class Assistant {


  Assistant({required this.category, required this.professional, required this.descriptionInstrumentation});

  final List<String> category;
  final String professional;
  final String descriptionInstrumentation;

  factory Assistant.fromJson(Map<String, dynamic> json)=> Assistant(
      category: List<String>.from(
          json["category"]),
      professional :json['professional'] ?? '',
      descriptionInstrumentation:json['descriptionInstrumentation'] ?? ''
  );


  Map<String, dynamic> toJson() => {
    "category": category,
    "professional": professional,
    "descriptionInstrumentation": descriptionInstrumentation,
  };
}
class Online {
  Online({required this.day, required this.from, required this.to});
  final String day;
  final String from;
  final String to;
}
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  final TextEditingController _infoController = TextEditingController();

  late Future<Album> futureAlbum;
  String dropdownValue ='מכבי';
  String description = '';
  String a='';
  String y='';
  String b='';
  String year='';
  String mail='';
  String hmo='';
  String info='';
  String ? idUser;
  late SharedPreferences s_prefs;

  String temp = '';

  _saveToShared_Preferences() async {
    s_prefs = await SharedPreferences.getInstance();
    s_prefs.setString("FIRST_NAME", _firstNameController.text.toString());
  }
  String inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null) {
      idUser = user.uid;
      return idUser.toString();
    }
    return '';
  }
  @override
  void initState() {
    super.initState();
    idUser=inputData();
    futureAlbum = fetchAlbum(idUser!.toString());
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
              const Text(
              "עדכון פרופיל",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.person,
            //       color: Colors.green,
            //     ),
            //     SizedBox(
            //       width: 8,
            //     ),
            //     Text(
            //       "Account",
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
            // buildAccountOptionRow(context, "Change password"),
            // buildAccountOptionRow(context, "Content settings"),
            // buildAccountOptionRow(context, "Social"),
            // buildAccountOptionRow(context, "Language"),
            // buildAccountOptionRow(context, "Privacy and security"),
            // SizedBox(
            //   height: 40,
            // ),
            Row(
              children: const [
                Icon(
                  Icons.edit,
                  color: Colors.blueAccent,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "כל מידע חשוב",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ]),
           FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                a=snapshot.data?.firstName ?? '';
                b=snapshot.data?.lastName ?? '';
                year=snapshot.data?.birthday ?? '';
                mail = snapshot.data?.email ?? 'yourmail@gmail.com';
                hmo = snapshot.data?.hmo ?? '';
                info = snapshot.data?.info ?? '';
                
                y =year.substring(0,4);
                //_controller.text=full;
               // _Zcontroller.text=snapshot.data?.lastName ?? '';
                //_birthdayController.text=y;
                return SingleChildScrollView(
                    child: Column(children: <Widget>[


                      RoundedInputField(

                        controller: _firstNameController,
                        hintText: "שם פרטי",
                        labelText: a,
                        icon: const Icon(Icons.person, color: Colors.blueAccent),
                        onChanged: (value) {
                          a=value.toString();
                        }
                      ),
                      RoundedInputField(
                        controller: _lastNameController,
                        hintText: "שם משפחה",
                        labelText: b,
                        icon: const Icon(Icons.person_add, color: Colors.blueAccent),
                        onChanged: (value) {
                          b=value.toString();
                        },
                      ),
                      RoundedInputField(
                        controller: _mailController,
                        hintText: "מייל",
                        labelText: mail,
                        icon: const Icon(Icons.mail_outline_outlined, color: Colors.blueAccent),
                        onChanged: (value) {
                          mail=value.toString();
                        },
                      ),
                      RoundedInputField(
                        controller: _birthdayController,
                        hintText: 'שנת לידה',
                        labelText: y,
                        icon: const Icon(Icons.numbers, color: Colors.blueAccent),
                        onChanged: (value) {
                          y=value.toString();
                        },
                      ),

                      RoundedInputField(
                        controller: _infoController,
                        hintText: 'לדוגמא אלרגי לגלוטן',
                        labelText: "פרטים חשובים",
                        icon: const Icon(Icons.info, color: Colors.blueAccent),
                        onChanged: (value) {
                          _infoController.text=value.toString();
                        },
                      ),


                      SizedBox(height: size.height * 0.005),
                      Row(
                          children:  [
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.medical_services,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "קופת חולים",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.lightBlue),
                              underline: Container(
                                width: 2,
                                height: 2,
                                color: kcolorapp,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['מכבי', 'כללית', 'לאומית', 'אחר']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),




                          ],






                      ),


                      //
    //                         DropdownButton<String>(
    //                           value: dropdownValue,
    //                           icon: const Icon(Icons.arrow_downward),
    //                           elevation: 16,
    //                           style: const TextStyle(color: Colors.blueGrey),
    //                           underline: Container(
    //                             height: 2,
    //                             color: kcolorapp,
    //                           ),
    //                           onChanged: (String? newValue) {
    //                             setState(() {
    //                               dropdownValue = newValue!;
    //                             });
    //                           },
    //                           items: <String>['מכבי', 'כללית', 'לאומית', 'אחר']
    //                               .map<DropdownMenuItem<String>>((String value) {
    //                             return DropdownMenuItem<String>(
    //                               value: value,
    //                               child: Text(value),
    //                             );
    //                           }).toList(),
    //                         ),
    //
    //
    //
    //
    //                       ],
    //
    //
    //
    //
    //
    //
    //
    //
    //

                      // Row(
                      //     children: const [
                      //       SizedBox(
                      //         width: 30,
                      //       ),
                      //       Icon(
                      //         Icons.info_rounded,
                      //         color: Colors.lightBlue,
                      //       ),
                      //       SizedBox(
                      //         width: 8,
                      //       ),
                      //       Text(
                      //         "מידע חשוב על עצמך",
                      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //       ),
                      //     ]),


                    SizedBox(height:20),
                      RoundedButton(
                          text: "הבא ",
                          press: ()  {
                            _saveToShared_Preferences();
                            futureAlbum =  updateAlbum(idUser!.toString(),_firstNameController.text, _lastNameController.text, _birthdayController.text, dropdownValue.toString(),description.toString() , _mailController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  HomeScreen()
                              ),
                            );
                            }

                          ),
                      SizedBox(height: size.height * 0.005),
                    ]));

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
           ),
          ],
    ),
    ));

  }
    bool isValid() {
    stderr.writeln(_firstNameController.text);
    stderr.writeln(_lastNameController.text);
    stderr.writeln(dropdownValue.toString());
    var newYear =int.parse(_birthdayController.text);
    int age =CURRENT_YEAR - newYear;
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_mailController.text);
    if(_firstNameController.text==''){
      _firstNameController.text=a;
    }
    if(isValidName(_firstNameController.text)&&isValidName(_lastNameController.text) &&emailValid && newYear < MAX_AGE_FOR_SIGN_UP ){

      return true;

    }
    return false;

  }

  bool isValidName(String name) {
    final validCharactersEnglish = RegExp(r'^[a-zA-Z _ \-=@,\.;]+$');
    final validCharactersHebrew = RegExp(r'^[\u0590-\u05FF_ \-=@,\.;]+$');

    if(name.length<2 || name.length>30) {
      return false;
    }
    if(name.isEmpty){
      return false;
    }
    if (validCharactersHebrew.hasMatch(name)){
      return true;
    }
    if(validCharactersEnglish.hasMatch(name)){
      return true;
    }
    return false;
  }
}