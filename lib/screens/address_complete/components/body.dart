


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/API/Http_Caller.dart';
import 'package:unity26_app_v1/Background.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/components/RoundedInputField.dart';
import 'package:unity26_app_v1/models/user_model.dart';
import 'package:unity26_app_v1/screens/is_assistant/is_assistant_screen.dart';

class Body extends StatefulWidget {
  final Address address;


  const Body({
    required this.address,

  });



  @override
  _Body createState() => _Body(address:address);
}

class _Body extends State<Body> {
  final streetController = TextEditingController();
  final  houseNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  final  cityController = TextEditingController();
  Address ?address;
  String ? houseNumber;
  String ? street;
  FirebaseAuth auth = FirebaseAuth.instance;
  String?  idUser;
  String ?phone;

  _Body({
    required this.address,
  });


  void inputData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user != null){
      idUser=user.uid;
      phone=user.phoneNumber!;
    }
    // here you write the codes to input the data into firestore
  }






  @override
  Widget build(BuildContext context) {

    inputData();
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: size.height / 2.5,
                width: 300,
                child: Background(child: Container()),
              ),
              RoundedInputField(
                controller: streetController,
                hintText: "",
                labelText: address!.street.toString(),
                icon: const Icon(Icons.streetview, color: Colors.blueGrey),
                onChanged: (value) {},
              ),
                RoundedInputField(
                  controller: houseNumberController,
                  hintText: "",
                  labelText: address!.houseNumber.toString(),
                  icon: const Icon(
                      Icons.home_work_rounded, color: Colors.blueGrey),
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  controller: apartmentNumberController,
                  hintText: "3",
                  labelText: "הזן מספר דירה",
                  icon: const Icon(Icons.home, color: Colors.red),
                  onChanged: (value) {},
                ),
              RoundedInputField(
                controller: cityController,
                hintText: "",
                labelText: address!.city.toString(),
                icon: const Icon(Icons.location_city, color: Colors.blueGrey),
                onChanged: (value) {},
              ),


              RoundedButton(
                  text: "הבא ",
                  press: () {
                    checkValidation();
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const IsAssistantScreen();
                          },
                        ),
                      );
                    }
                  ),
              SizedBox(height: size.height * 0.005),
            ])));
  }

 bool checkValidation(){
    if(apartmentNumberController.text.isEmpty) {
      return false;
    }
    else{
      address!.apartmentNumber=apartmentNumberController.text;
      updateLocation(idUser!,address!);
      return true;


    }



  }

  @override
  void dispose() {
   streetController.dispose();
   houseNumberController.dispose();
   apartmentNumberController.dispose();
   cityController.dispose();
    super.dispose();
  }








}