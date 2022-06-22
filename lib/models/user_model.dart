
import 'package:flutter/foundation.dart';

class UserModel {
  String id;
  String phone;
  int v;
  String firstName;
  String lastName;
  String birthday;
  List<Contact> contacts;
  String email;
  String hmo;
  String info;
  Address  ? address;
  Assistant ? assistant;

  //final Assistant assistant;
   UserModel({
    required this.id,
    required this.phone,
    required this.v,
     required this.firstName ,
    required this.lastName,
    required this.birthday,
    required this.email,
    required this.hmo,
    required this.info,
    required this.contacts,
    required this.address,
    required this.assistant,

    //required this.assistant,
  });

  // UserModel copy({
  //   String ? id,
  //   String ? phone,
  //   int? v,
  //   String ? img ,
  //   String  ? firstName,
  //   String  ? lastName,
  //   String  ? birthday,
  //   String  ? email ,
  //   Address ? address,
  //   Assistant ? assistant,
  //   String ? hmo ,
  //   String  ? info,
  // }) =>
  //     UserModel(
  //       id: id ?? this.id,
  //       phone: phone ?? this.phone,
  //       v:v ??this.v,
  //       img: img ?? this.img,
  //       firstName: firstName ?? this.firstName,
  //       lastName: lastName ??this.lastName,
  //       birthday:  birthday ?? this.birthday,
  //       address: address ??this.address ,
  //       assistant: assistant?? this.assistant,
  //       email: email ?? this.email,
  //       hmo: hmo ?? this.hmo,
  //       info: info ?? this.info,
  //     );
  //

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      id: json["_id"],
      phone: json["phone"],
      v: json["__v"] as int,
      firstName: json["firstName"],
      lastName: json["lastName"],
      birthday: json["birthday"],
      email: json["birthday"] ?? '',
      hmo:json["hmo"] ?? '',
      info: json["info"] ?? '',
      address:Address.fromJson(json['address']),
      assistant: Assistant.fromJson(json['assistant']),
      contacts: List<Contact>.from(
          json["contacts"].map((x) => Contact.fromJson(x))),
      //assistant: Assistant.fromJson(json["assistant"])
    );
  }
}




class Assistant {


  Assistant({required this.category,required this.days,required this.hours, required this.professional, required this.descriptionInstrumentation});

   List<String> category;
   List<String> days;
   Hours hours;
   String professional;
   String descriptionInstrumentation;

  factory Assistant.fromJson(Map<String, dynamic> json)=> Assistant(
      category: List<String>.from(
          json["category"]),
      days:  List<String>.from(
          json["days"]),
      hours:Hours.fromJson(json['hours']),
      professional :json['professional'] ?? '',
      descriptionInstrumentation:json['descriptionInstrumentation'] ?? ''
  );


  Map<String, dynamic> toJson() => {
    "category": category,
    "days":days,
    "hours":hours.toJson(),
    "professional": professional,
    "descriptionInstrumentation": descriptionInstrumentation,
  };
}



class Hours{
  String from;
  String to;
  Hours(this.from,this.to);
  Hours.fromJson(Map<String, dynamic> json):
        from= json['from'],
        to=json['to'];

  Map<String, dynamic> toJson() => { "from" : from, "to" : to};
}




class Address {
  String city;
  String street;
  String ? apartmentNumber;
  String houseNumber;
  Address(this.city, this.street, this.apartmentNumber, this.houseNumber);
  Address.fromJson(Map<String, dynamic> json):
        city= json['city'],
        street=json['street'],
        apartmentNumber=json['apartmentNumber'],
        houseNumber=json['houseNumber'];
  Map<String, dynamic> toJson() => { "city" : city, "street" : street, "apartmentNumber": apartmentNumber,"houseNumber": houseNumber};
}
class Contact {
  Contact({
    required this.name,
    required this.phone,
  });

  String name;
  String phone;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json["name"] ?? '',
    phone: json["phone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}
