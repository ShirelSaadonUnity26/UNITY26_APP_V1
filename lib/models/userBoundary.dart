import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unity26_app_v1/models/user.dart';


class UserBoundary {
  String userId;
  String phone;
  String firstName;
  String lastName;
  String birthday;
  UserBoundary(this.userId,this.phone,this.firstName, this.lastName,
      this.birthday);
  UserBoundary.fromJson(Map<String, dynamic> json):
        userId = json['_id'],
        phone = json['phone'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        birthday = json['birthday'];

  Map<String, dynamic> toJson() =>
      {

        '_id':userId,
        'phone':phone,
        'firstName': firstName,
        'lastName': lastName,
        'birthday': birthday
      };

  @override
  String toString() {
    return 'UserBoundary{userId: $userId, phone: $phone, firstName: $firstName, lastName: $lastName, birthday: $birthday}';
  }
}
class Address {

  String city;
  String street;
  String apartmentNumber;
  String houseNumber;


  Address(this.city, this.street, this.apartmentNumber, this.houseNumber);



  Address.fromJson(Map<String, dynamic> json)
      :
        city= json['city'],
        street=json['street'],
        apartmentNumber=json['apartmentNumber'],
        houseNumber=json['houseNumber'];

  Map<String, dynamic> toJson() => { "city" : city, "street" : street, "apartmentNumber": apartmentNumber,"houseNumber": houseNumber};
}