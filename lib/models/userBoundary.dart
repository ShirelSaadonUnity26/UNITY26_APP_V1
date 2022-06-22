
class UserBoundary {
  String userId;
  String phone;
  String firstName;
  String lastName;
  String birthday;
  //Address address;
  //Assistant assistant;



  UserBoundary(this.userId, this.phone, this.firstName, this.lastName,
      this.birthday);

  UserBoundary.fromJson(Map<String, dynamic> json):
        userId = json['_id'] ?? '',
        phone = json['phone'] ?? '',
        firstName = json['firstName'] ?? '',
        lastName = json['lastName']?? '',
        birthday = json['Birthday'] ?? '';
        //address=Address.fromJson(json['address']



  Map<String, dynamic> toJson() =>
      {
        '_id':userId,
        'phone':phone,
        'firstName': firstName,
        'lastName': lastName,
        'Birthday': birthday,


      };

  @override
  String toString() {
    return 'UserBoundary{userId: $userId, phone: $phone}';
  }
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
// enum  Category { ALL, MEDICAL, CAR, ANIMAL, LIFESAVER, THEFTS ,POLICE}
//
//
// extension CategoryMap on Category {
//   static const valueMap = {
//     Category.ALL:"ALL",
//     Category.MEDICAL:"MEDICAL",
//     Category.CAR:"CAR",
//     Category.ANIMAL:"ANIMAL",
//     Category.LIFESAVER:"LIFESAVER",
//     Category.THEFTS:"THEFTS",
//     Category.POLICE:"POLICE"
//   };
//   String? get value => valueMap[this];
//
//   static Category fromString(String input) {
//     final reverseValueMap = valueMap.map<String, Category>((key, value) => MapEntry(value, key));
//
//     Category? output = reverseValueMap[input];
//     if(output == null) {
//       throw 'Invalid String Input';
//     }
//
//     return output;
//   }
// }
class Assistant {
  List<String> category;
  String professional;
  String descriptionInstrumentation;

  Assistant(this.category, this.professional, this.descriptionInstrumentation);

  Assistant.fromJson(Map<String, dynamic> json)
      :
        category = json['category'],
        professional = json['professional'],
        descriptionInstrumentation=json['descriptionInstrumentation'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['professional'] = professional;
    data['descriptionInstrumentation'] = descriptionInstrumentation;
    return data;
  }
}


