class UserNew {
  final String id;
  final String phone;
  final String name;
  final String lastName;
  final String birthday;
  final int vv;

  UserNew(
      this.id,
      this.phone,
      this.name,
      this.lastName,
      this.birthday,
      this.vv
      );
  factory UserNew.fromMap(Map<String, dynamic> json) {
    return UserNew(json['_id'], json['phone'], json['firstName'], json['lastName'],json['birthday'],json['__v']);
  }
  factory UserNew.fromJson(Map<String, dynamic> json) {
    return UserNew(json['_id'], json['phone'], json['firstName'], json['lastName'],json['birthday'],json['__v']);
  }
}