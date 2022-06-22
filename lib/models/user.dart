class MyUser{
  final String idUser;
  final String phone;
  final String firstName;
  final String lastName;
  final String birthday;
  final int __v;
  //final Assistant assistant;


  MyUser(this.idUser, this.phone, this.firstName, this.lastName, this.birthday,this.__v);

  MyUser.fromJson(Map<String, dynamic> json)
      : idUser = json['_id'] as String,
        phone = json['phone'] as String,
        firstName= json['firstName']as String,
        lastName= json['lastName']as String,
        birthday= json['birthday'] as String,
        __v=json['__v']as int
   ;


  Map<String, dynamic> toJson() => {

    '_id':idUser,
    'phone':phone,
    'firstName':firstName,
    'lastName':lastName,
    'birthday':birthday,
    '__v':__v

  };
}
class Assistant {
  List<String> category;
  String professional;
  String descriptionInstrumentation;

  Assistant(this.category, this.professional, this.descriptionInstrumentation);

  Assistant.fromJson(Map<String, dynamic> json)
      :
        category = json['category'] as List<String>,
        professional = json['professional'] as String,
        descriptionInstrumentation=json['descriptionInstrumentation'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['professional'] = professional;
    data['descriptionInstrumentation'] = descriptionInstrumentation;
    return data;
  }
}
