import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/online/online_data.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<Assistant> futureAssistant;

  String dropdownValueFrom ='00:00';
  String dropdownValueTo ='23:59';
  List <String> temp = [];
  String ? idUser;



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
    futureAssistant = fetchAssistant(idUser!.toString());
  }
  Widget stringSwitch(
      String text, bool val, bool newval, Function onChangedMethod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
        text,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]),
      ),
          Transform.scale(
          scale: 0.7,

          child:CupertinoSwitch(
              trackColor: Colors.black12,
              activeColor: Colors.green,
              value: val,
              onChanged: (newval) {
                onChangedMethod(newval);
              })

          ),

      ],
    );



  }
  String professional='';
  String des='';
  Hours hours=Hours('', '');
  List<String> category=[];
  List <String> days=[];

  List<int> numbers = [1, 2, 3, 4, 5, 6, 7];
  bool value = false;
  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool isSwitched5 = false;
  bool isSwitched6 = false;
  final professionalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = OnlineData.myUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
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
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            FutureBuilder<Assistant>(
              future: futureAssistant,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  hours=snapshot.data?.hours ?? Hours('', '');
                  days=snapshot.data?.days ?? [];
                  category=snapshot.data?.category ?? [];
                  des = snapshot.data?.descriptionInstrumentation ?? '';
                  professional = snapshot.data?.professional ?? '';


                  return Text(snapshot.data!.professional);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            const Text(
              "הגדרות מערך הסיוע",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "התראות",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            stringSwitch('מעוניין לקבוע את שעות פעילות ההתראות', val0, newval0?? true, onChangedFunction0),
            const SizedBox(
              height: 10,
            ),
            Text('באפשרותך לקבוע שעות וימים בהם תוכל לקבל התראות',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
            children: [
              Text('משעה',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
              const SizedBox(
                width: 10,
              ),
            DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Color.fromRGBO(230, 255, 255, 0.99), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left:30, right:30),
                    child:DropdownButton<String>(
                      value: dropdownValueFrom,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValueFrom = newValue!;
                        });
                      },
                      items: <String>['00:00', '01:00', '02:00', '03:00','04:00',
                      '05:00','06:00','07:00','08:00','09:00',
                      '10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00',
                      '19:00','20:00','21:00','22:00','23:00'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )

                )
            ),

              const SizedBox(
                width: 10,
              ),
              Text('עד שעה',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
              const SizedBox(
                width: 10,
              ),
              DecoratedBox(
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(230, 255, 255, 0.99), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left:30, right:30),
                      child:DropdownButton<String>(
                        value: dropdownValueTo,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueTo = newValue!;
                          });
                        },
                        items: <String>['00:00', '01:00', '02:00', '03:00','04:00',
                          '05:00','06:00','07:00','08:00','09:00',
                          '10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00',
                          '19:00','20:00','21:00','22:00','23:59'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),

                      )

                  )
              ),

            ]
            ),
            const SizedBox(
              height: 20,
            ),


            stringSwitch('כל יום א', val1, newval1?? true, onChangedFunction1),
            stringSwitch('כל יום ב', val2, newval2?? true, onChangedFunction2),
            stringSwitch('כל יום ג', val3, newval3?? true, onChangedFunction3),
            stringSwitch('כל יום ד', val4, newval4?? true, onChangedFunction4),
            stringSwitch('כל יום ה', val5, newval5?? true, onChangedFunction5),
            stringSwitch('כל יום ו', val6, newval6?? true, onChangedFunction6),
            stringSwitch('כל יום ש', val7, newval7?? true, onChangedFunction7),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  x();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return  HomeScreen();
                      },
                    ),
                  );
                  showSnackBar(context, 'הגדרת בהצלחה את שעות פעילות ההתראות');
                },
                child: const Text("סיום",
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
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(

                value: isActive,
                onChanged: (v) =>

                    setState(() => isActive= v

    )



            ),

        )

      ],

    );
  }
  bool val2 = false, val3 = false ,val4 =false ,val5=false,val6=false ,val7=false, val0=false;
  bool val1 =false;
  bool ? newval1, newval2, newval3,newval4,newval5,newval6,newval7,newval0;

  // void setss(){
  //   if (days.isNotEmpty){
  //     if(days.contains('1')){
  //       val1=true;
  //     }else{
  //       val1 = false;
  //     }
  //     if(days.contains('2')){
  //       val2=true;
  //     }else{
  //       val2 = false;
  //     }
  //     if(days.contains('3')){
  //       val3=true;
  //     }else{
  //       val3 = false;
  //     }
  //     if(days.contains('4')){
  //       val4=true;
  //     }else{
  //       val4 = false;
  //     }
  //
  //     if(days.contains('5')){
  //       val5=true;
  //     }else{
  //       val5 = false;
  //     }
  //     if(days.contains('6')){
  //       val6=true;
  //     }else{
  //       val6 = false;
  //     }
  //     if(days.contains('7')){
  //       val7=true;
  //     }else{
  //       val7 = false;
  //     }
  //
  //   }
  //
  //
  //
  // }

  void x(){
    stderr.writeln(temp.toList());
    stderr.writeln(dropdownValueFrom);
    stderr.writeln(dropdownValueTo);
    Hours h=Hours(dropdownValueFrom.toString(), dropdownValueTo.toString());
    Assistant assistant=Assistant(category: category, days: temp.toList(), hours: h, professional: professional, descriptionInstrumentation: des);
    updateAssistant(idUser!, assistant);











  }



  onChangedFunction1(bool newval1) {
    setState(() {
      val1 = newval1;

      temp.add('1');



    });
  }

  onChangedFunction2(bool newval2) {
    setState(() {
      val2 = newval2;
      temp.add('2');
    });
  }

  onChangedFunction3(bool newval3) {
    setState(() {
      val3 = newval3;
      temp.add('3');
    });
  }

  onChangedFunction4(bool newval4) {
    setState(() {
      val4 = newval4;
      temp.add('4');
    });
  }
  onChangedFunction5(bool newval5) {
    setState(() {
      val5 = newval5;
      temp.add('5');
    });
  }
  onChangedFunction6(bool newval6) {
    setState(() {
      val6 = newval6;
      temp.add('6');

    });
  }
  onChangedFunction7(bool newval7) {
    setState(() {
      val7 = newval7;
      temp.add('7');
    });
  }
  onChangedFunction0(bool newval0) {
    setState(() {
      val0 = newval0;
    });
  }
  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
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
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 4,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }


  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.all( 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                   Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: const TextStyle(fontSize: 12, height: 1.4),
                            ))),
                    const Icon(
                      Icons.edit,
                      color: Colors.green,
                      size: 30.0,
                    )
                  ])
            ],
          ));


  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }


  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
