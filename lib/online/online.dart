class Online {

   String  day;
   String  from;
   String   to;



  // Constructor
  Online({
    required this.day ,
    required this.from,
    required this.to,

  });

  Online copy({
    String? day,
    String? from,
    String? to,

  }) =>
      Online(
        day: day ?? this.day,
        from: from ?? this.from,
        to: to ?? this.to,

      );

  static Online fromJson(Map<String, dynamic> json) =>
      Online(
        day: json['day'],
        from: json['from'],
        to: json['to'],

      );

  Map<String, dynamic> toJson() =>
      {
        'day': day,
        'from': from,
        'to': to,

      };
}