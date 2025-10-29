class Patient {
  final String name;
  final String email;
  final String password;
  final String? chronicDisease;
  final String? allergy;

  Patient({
    required this.name,
    required this.email,
    required this.password,
    this.chronicDisease,
    this.allergy,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "chronicDisease": chronicDisease,
    "allergy": allergy,
  };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    chronicDisease: json["chronicDisease"],
    allergy: json["allergy"],
  );
}
