class User1 {
  String userId;
  String phone;
  String firstName;
  String lastName;
  String birthday;

  // Constructor
  User1( {
    required this.userId,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.birthday,
  });

  User1 copy({
    String? userId,
    String? phone,
    String? firstName,
    String? lastName,
    String? birthday

  }) =>
      User1(
        userId: userId ?? this.userId,
        phone: phone ?? this.phone,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        birthday: birthday ?? this.birthday,
      );

  static User1 fromJson(Map<String, dynamic> json) => User1(

    userId: json['_id'],
    phone:json['phone'],
    firstName :json['firstName'],
    lastName :json['lastName'],
    birthday:json['birthday'],
  );

  Map<String, dynamic> toJson() => {
    '_id':userId,
    'phone':phone,
    'firstName': firstName,
    'lastName': lastName,
    'birthday': birthday,
  };
}