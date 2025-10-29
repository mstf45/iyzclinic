class Doctor {
  final String name;
  final String email;
  final String password;
  final String specialty;

  Doctor({
    required this.name,
    required this.email,
    required this.password,
    required this.specialty,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "specialty": specialty,
  };

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    specialty: json["specialty"],
  );
}
